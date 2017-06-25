#Dockerfile
FROM php:5.6-apache

#init image
LABEL Description="This image is used to start the php5.6 server with Shopware for dev" Vendor="niwde" Version="1.0"
ARG shop_version
ARG shop_branch

#create user shopware for group www-data
RUN useradd -G www-data --create-home --shell /bin/bash shopware
RUN echo 'shopware:shopware' | chpasswd

#create downloads folder
RUN mkdir -p /home/shopware/Downloads

# copy php.ini for user
COPY config/php.ini /usr/local/etc/php/
# apache2 rewrite mode
RUN a2enmod rewrite

# Common
# Install ant
RUN apt-get update && \
    apt-get install ant -y
# Install Vim
RUN apt-get update && \
    apt-get install vim -y
# Install openssl
RUN apt-get update && apt-get install openssl -y
# Install git
RUN apt-get update && apt-get install git -y
# Install unzip
RUN apt-get update && apt-get install -y unzip
# Install mercurial
#RUN apt-get update && apt-get install -q -y mercurial
#to use with mercurial without prompting user and pass
#COPY config/.hgrc /home/shopware/

#PHP extensions
# Install bz2
RUN apt-get update && apt-get install -y \
		libbz2-dev \
	&& docker-php-ext-install bz2
# Install zip
RUN apt-get update && apt-get install -y \
		libzip-dev \
	&& docker-php-ext-install zip
# Install php extensions: mysql mysqli pdo_mysql
RUN docker-php-ext-install mysql mysqli pdo_mysql
# Install ioncube
ADD resources/ioncube.tar.gz /home/shopware/Downloads/
RUN cd /home/shopware/Downloads/ \
    && mv ioncube/ioncube_loader_lin_5.6.so /usr/local/lib/php/extensions/* \
	&& echo "zend_extension=ioncube_loader_lin_5.6.so" > /usr/local/etc/php/conf.d/00_docker-php-ext-ioncube_loader_lin_5.6.ini
# Install mcrypt
RUN apt-get update && apt-get install -y \
        libmcrypt-dev \
    && docker-php-ext-install -j$(nproc) mcrypt
# Install intl
RUN apt-get update && apt-get install -y \
        libicu-dev \
    && docker-php-ext-install -j$(nproc) intl
#RUN add pecl proxy (use the args proxy settings)
#RUN pear config-set http_proxy $http_proxy system
#RUN pear config-set http_proxy $http_proxy user
# Install memcached
RUN apt-get update && apt-get install -y \
		libmemcached-dev \
		zlib1g-dev \
    && pecl install memcached-2.2.0 \
    && docker-php-ext-enable memcached
# Install gd && iconv
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng12-dev \
	&& docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd
# Install soap
RUN apt-get update && apt-get install -y \
		libxml2-dev \
		php-soap \
	&& docker-php-ext-install -j$(nproc) soap
# Install xdebug
RUN apt-get update && apt-get install php5-xdebug -y \
	&& pecl install xdebug-2.5.5 \
	&& docker-php-ext-enable xdebug
# Install gettext && mbstring
RUN docker-php-ext-install \
	gettext \
	mbstring
# others
RUN docker-php-ext-install \
	sockets \
	calendar \
	sysvmsg \
	sysvsem \
	sysvshm

# Install composer and put binary into $PATH
RUN curl -sS https://getcomposer.org/installer | php \
	&& mv composer.phar /usr/local/bin/ \
	&& ln -s /usr/local/bin/composer.phar /usr/local/bin/composer

# Install NodeJS
#RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - \
#	&& apt-get install -y nodejs

# Install Grunt globally
#RUN npm install -g grunt-cli
# Install Gulp globally
#RUN npm install -g gulp-cli
# Install Bower globally
#RUN npm install -g bower

# Clean
RUN apt-get clean

#dev ports
EXPOSE 9000

# Add scripts
ADD ./scripts/installWebshop.sh /home/shopware/scripts/
#ENTRYPOINT ["docker-php-entrypoint"]
