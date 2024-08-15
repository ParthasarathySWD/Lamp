FROM mysql
LABEL Name=db Version=8.0.28 Description="Mysql server for dev environment"
# VOLUME ${PWD}/config-file.cnf /etc/mysql/conf.d


ENV MYSQL_ROOT_PASSWORD MYSQL_ROOT_PASSWORD
ENV MYSQL_DATABASE MYSQL_DATABASE
ENV MYSQL_USER MYSQL_USER
ENV MYSQL_PASSWORD MYSQL_PASSWORD

EXPOSE 3306

# Copy starting scripts file
COPY start.sh /root/start.sh
COPY ./config/entrypoint.sh /entrypoint.sh

# Run necessary services
CMD ["/bin/bash", "/root/start.sh"]