#!/bin/bash

su 'webshop'
#clone Shopware from Official git
cd /var/www/html/
git clone https://github.com/shopware/shopware.git
cd /var/www/html/shopware
tags="$(git tag -l) | grep $shop_version"
branch="$(git branch -l) | grep $shop_branch"
if [[ -n $shop_version && -n $tags && -n $branch ]]
	git checkout "tags/v${shop_version}" -b ${branch}
elif [[ -n $shop_version && -n $tags ]]; then
	git checkout "tags/v${shop_version}"
fi
echo 'clone finished'

#build shopware
cd /var/www/html/shopware/build
#ant configure
echo 'start ant tasks'
ant -Ddb.host=127.0.0.1 -Ddb.name=shopware -Ddb.user=shopware -Duser.db.password=shopware -Ddb.password=shopware -Ddb.port=3306 write-properties

#make sure the mysql service is running
status="$(/etc/init.d/mysql status)"
if [[ "${status}" != *"Uptime"* ]]; then
		echo "start mysql server"
        /etc/init.d/mysql start
fi

echo 'start build-unit'
ant build-unit
echo 'finish build-unit'

cd /var/www/html/shopware
#TODO download test_images
#unzip -d . /home/webshop/Downloads/test_images.zip

# set the rights to www-data and shopware
chown -R www-data:www-data /var/www/html/ \
	&& chmod -R 777 /var/www/html/
chown -R webshop:www-data /home/shopware \
	&& chmod -R 777 /home/shopware
