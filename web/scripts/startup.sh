#!/bin/bash

#check if apache2 is started
status="$(/etc/init.d/apache2 status)"
if [[ "${status}" != "apache2 is running." ]]; then
		echo "start apache2 server"
        /etc/init.d/apache2 start
fi

#start mysql safe
/etc/init.d/mysql stop
status="$(/etc/init.d/mysql status)"
if [[ "${status}" != *"Uptime"* ]]; then
		echo "start mysql server safe"
        /usr/bin/mysqld_safe
fi