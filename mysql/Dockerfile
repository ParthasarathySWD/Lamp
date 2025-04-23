FROM mysql
LABEL Name=db Version=8.0.28 Description="Mysql server for dev environment"
# VOLUME ${PWD}/config-file.cnf /etc/mysql/conf.d


ENV MYSQL_ROOT_PASSWORD=root_password
ENV MYSQL_DATABASE=database_name
ENV MYSQL_USER=user_name
ENV MYSQL_PASSWORD=user_password

EXPOSE 3306

# Copy starting scripts file
COPY start.sh /root/start.sh
COPY ./config/entrypoint.sh /entrypoint.sh

# Run necessary services
CMD ["/bin/bash", "/root/start.sh"]