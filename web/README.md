# docker-shopware - build image
It creates an image for shopware development

##How to build the image

The simplest way is the best way:

*docker build -t mytag pathToDockerfile*

###Arguments
If you are interested in a specific Shopware Version just give as build arguments the *shop_version* and the *shop_branch*

*docker build -t mytag pathToDockerfile --build-arg shop_version=5.2.20*

*docker build -t mytag pathToDockerfile --build-arg shop_version=5.3.0 --build-arg shop_branch=5.3*

Either of the arguments aren't mandatory.

Other useful argument can be http_proxy - if you are behind a proxy
for more check: https://docs.docker.com/engine/reference/builder/#arg

###Configurations
In the */config* folder are two files.
*.hgrc* to set credentials for mercurial repository (optional)
*php.ini* to adjust the php options
