# switch_point_test

# Usage
```shell
# Reset MySQL data & log directories (if necessary)
$ rm -rf docker/mysql_{reader,writer}/{data,log}
$ mkdir docker/mysql_{reader,writer}/{data,log}

# Launch docker-compose
$ docker-compose up

# Setup database (if necessary)
$ docker-compose exec rails rake db:setup

# Open https://127.0.0.1:3333
```
