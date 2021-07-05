FROM ubuntu:20.04

LABEL MAINTAINER="Kingfatehkhan786@gmail.com"

ENV ITDEVGROUP_TIME_ZONE Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$ITDEVGROUP_TIME_ZONE /etc/localtime && echo $ITDEVGROUP_TIME_ZONE > /etc/timezone


RUN DEBIAN_FRONTEND=noninteractive     && apt-get update \
    && yes | apt upgrade 

RUN apt-get update -yq \
    && apt-get install -yq \
	ca-certificates \
    git \
    gcc \
    make \
    wget \
    mc \
    curl \
    cron \
    zip \
    supervisor 

RUN DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common
RUN DEBIAN_FRONTEND=noninteractive LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php




RUN  apt update \ 
     && apt-get -y install gcc make autoconf libc-dev pkg-config libzip-dev  
     
RUN yes | apt install php7.4-fpm \  
         php7.4-mysql \ 
          php7.4-gmp \ 
             php7.4-xmlrpc\ 
               php7.4-xml \  
               php7.4-zip \
               	php7.4-opcache \
                php7.4-common \
                php7.4-mbstring \
                php7.4-soap \
                php7.4-cli \
                php7.4-intl \
                php7.4-json \
                php7.4-xsl \
                php7.4-imap \
                php7.4-ldap \
                php7.4-curl \
                php7.4-gd  


COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN echo "date.timezone=$ITDEVGROUP_TIME_ZONE" > /etc/php/7.4/cli/conf.d/timezone.ini
RUN  mkdir -p /var/www/html
COPY ./Server_conf/site.conf/php-fpm.conf /etc/php/7.4/fpm/pool.d/www.conf
RUN  cat /etc/php/7.4/fpm/pool.d/www.conf 
RUN  service php7.4-fpm restart
USER root
ENTRYPOINT  ["/usr/bin/supervisord"]



