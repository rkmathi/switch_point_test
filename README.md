# switch_point_test

# Setup
```shell
$ rm -rf docker/mysql_{reader,writer}/{data,log}
$ mkdir docker/mysql_{reader,writer}/{data,log}

$ docker-compose up

$ docker-compose exec rake db:setup

#=> Open https://127.0.0.1:3333
```
