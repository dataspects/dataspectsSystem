#!/bin/bash

user@host:~/dataspectsSystemBuilder$ scp -P 2222 docker-compose.yml dserver@localhost:/home/dserver/

# dserver@dserver:~$ sudo docker-compose up -d
# dserver@dserver:~$ sudo chown -R www-data:dserver ./mediawiki_root
# dserver@dserver:~$ sudo chmod -R 777 ./elasticsearch_data