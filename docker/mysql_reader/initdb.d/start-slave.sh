#!/bin/bash

WRITER_HOST=mysql_writer
WRITER_PORT=3334

echo 'BEGIN.'

while ! mysqladmin ping -h "$WRITER_HOST" -P "$WRITER_PORT" --silent; do
  sleep 1
done
echo 'START WRITER.'

mysql -u root -h "$WRITER_HOST" -P "$WRITER_PORT" -e "RESET MASTER;"
mysql -u root -h "$WRITER_HOST" -P "$WRITER_PORT" -e "FLUSH TABLES WITH READ LOCK;"
echo 'FLUSH MATER.'

mysqldump -u root -h "$WRITER_HOST" -P "$WRITER_PORT" --all-databases --master-data --single-transaction --flush-logs --events > /tmp/master_dump.sql
echo 'DUMP.'

mysql -u root -e "STOP SLAVE;";
mysql -u root < /tmp/master_dump.sql
echo 'STOP SLAVE.'

log_file=`mysql -u root -h "$WRITER_HOST" -P "$WRITER_PORT" -e "SHOW MASTER STATUS\G" | grep File: | awk '{print $2}'`
pos=`mysql -u root -h "$WRITER_HOST" -P "$WRITER_PORT" -e "SHOW MASTER STATUS\G" | grep Position: | awk '{print $2}'`

mysql -u root -e "RESET SLAVE";
mysql -u root -e "CHANGE MASTER TO MASTER_HOST='${WRITER_HOST}', MASTER_PORT=${WRITER_PORT}, MASTER_USER='root', MASTER_PASSWORD='', MASTER_LOG_FILE='${log_file}', MASTER_LOG_POS=${pos};"
mysql -u root -e "START SLAVE"
echo 'START SLAVE.'

mysql -u root -h "$WRITER_HOST" -P "$WRITER_PORT" -e "UNLOCK TABLES;"
echo 'DONE.'
