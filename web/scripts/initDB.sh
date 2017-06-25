#!/bin/bash

status="$(/etc/init.d/mysql status)"
if [[ "${status}" != *"Uptime"* ]]; then
		echo "start mysql server"
        /etc/init.d/mysql start
fi

echo "GRANT USAGE ON *.* TO 'webshop'@'localhost';" | mysql
echo "DROP USER 'webshop'@'localhost';" | mysql
echo "create user webshop@localhost identified by 'webshop';" | mysql
#import db
cd /home/webshop/WebshopsZips/Shopware
echo "create database shopware_dev;" | mysql
echo "GRANT ALL ON *.* TO webshop@localhost IDENTIFIED BY 'webshop' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql