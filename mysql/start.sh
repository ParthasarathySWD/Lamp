#!/bin/sh

cp /etc/mysql/conf.d/source/* /etc/mysql/conf.d/

/usr/local/bin/docker-entrypoint.sh mysqld