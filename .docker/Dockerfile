FROM amazonlinux:2016.09

RUN mkdir webapp

# 起動時のシェルをコピー
COPY startup.sh /startup.sh
RUN chmod +x /startup.sh
CMD ["/startup.sh"]


RUN rm -f /etc/localtime
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN yum update -y
RUN yum install -y procps curl vim gcc gcc-c++ make zlib-devel git


# apacheのインストール
RUN yum list available | grep httpd
RUN yum -y install httpd24
RUN yum -y install openssl
RUN yum -y install mod24_ssl
# apacheの設定
RUN chkconfig httpd on
RUN cp -p /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.org
COPY files/httpd.conf /etc/httpd/conf/httpd.conf
COPY files/vhost.conf /etc/httpd/conf.d/vhost.conf
COPY files/index.php /var/www/html/index.php


# phpのインストール
RUN yum list available | grep php70
RUN yum install -y php70 php70-devel php70-mbstring php70-pdo php7v-gd php70-xml php70-mcrypt
# phpの設定
RUN cp -p /etc/php.ini /etc/php.ini.org
RUN sed -i -e "s|;date.timezone =|date.timezone = Asia/Tokyo|" /etc/php.ini
RUN sed -i -e "s|expose_php = On|expose_php = Off|" /etc/php.ini
RUN sed -i -e "s|;error_log = syslog|error_log = /var/log/php.log|" /etc/php.ini
RUN sed -i -e "s|;mbstring.language = Japanese|mbstring.language = Japanese|" /etc/php.ini
RUN sed -i -e "s|;mbstring.internal_encoding =|mbstring.internal_encoding = UTF-8|" /etc/php.ini
RUN sed -i -e "s|;mbstring.http_input =|mbstring.http_input = UTF-8|" /etc/php.ini
RUN sed -i -e "s|;mbstring.http_output =|mbstring.http_output = pass|" /etc/php.ini
RUN sed -i -e "s|;mbstring.encoding_translation = Off|mbstring.encoding_translation = On|" /etc/php.ini
RUN sed -i -e "s|;mbstring.detect_order = auto|mbstring.detect_order = auto|" /etc/php.ini
# php composerのインストール
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer


# nodeのインストール
RUN curl --silent --location https://rpm.nodesource.com/setup_6.x | bash
RUN yum install -y nodejs
RUN npm install -g typescript


RUN httpd -v
RUN php -v
RUN node -v

WORKDIR /

EXPOSE 80 443
