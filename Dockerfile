FROM ubuntu:18.04
MAINTAINER Patrick Aymarn <patrick@aymar.me>

VOLUME ["/var/moodledata"]
COPY moodle-config.php /var/www/html/config.php

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Database info and other connection information derrived from env variables. See readme.
# Set ENV Variables externally Moodle_URL should be overridden.
ENV MOODLE_URL http://127.0.0.1

ADD ./foreground.sh /etc/apache2/foreground.sh
RUN apt-get update
RUN apt -y install software-properties-common
RUN add-apt-repository ppa:ondrej/php
RUN apt -y install php7.4
RUN apt-get update && \
	apt-get -y install mysql-client pwgen python-setuptools curl git unzip apache2 \
		php7.4-gd php7.4-pgsql php7.4-curl php7.4-xmlrpc php7.4-xml php7.4-mbstring php7.4-mysql php7.4-soap php7.4-zip php7.4-intl\
		libapache2-mod-php postfix wget supervisor curl libcurl4 vim\
		libcurl3-dev git-core cron  && \
	cd /tmp && \
	git clone -b MOODLE_38_STABLE git://git.moodle.org/moodle.git --depth=1 && \
	mv /tmp/moodle/* /var/www/html/ && \
	rm /var/www/html/index.html && \
	chown -R www-data:www-data /var/www/html && \
	chmod +x /etc/apache2/foreground.sh

COPY php/php.ini /etc/php5/cli/php.ini
#cron
COPY moodlecron /etc/cron.d/moodlecron
RUN chmod 0644 /etc/cron.d/moodlecron

# Cleanup, this is ran to reduce the resulting size of the image.
#RUN apt-get clean autoclean && apt-get autoremove -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/lib/dpkg/* /var/lib/cache/* /var/lib/log/*

CMD ["/etc/apache2/foreground.sh"]
