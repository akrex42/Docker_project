FROM debian:buster

# RUN apt-get install -y nginx && apt-get install -y mysql-service && apt-get install -y myphpadmin && apt-get install wordpress
COPY src/nginx.conf /etc/nginx/conf.d/
COPY src/config.inc.php phpmyadmin
COPY src/wp-config.php /var/www/html
COPY src/script.sh /script/
EXPOSE 80 443
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install wget
RUN apt-get -y install nginx
RUN apt-get -y install mariadb-server
RUN apt-get -y install php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring
WORKDIR /var/www/html/
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz
RUN tar -xf phpMyAdmin-5.0.1-english.tar.gz && rm -rf phpMyAdmin-5.0.1-english.tar.gz
RUN mv phpMyAdmin-5.0.1-english phpmyadmin
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvzf latest.tar.gz && rm -rf latest.tar.gz
RUN openssl req -x509 -nodes -days 365 -subj "/C=RU/ST=Moscow/L=Moscow/O=school21/OU=students/emailAddress=polina.s.nekrasova@gmail.com/CN=localhost" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt
RUN chown -R www-data:www-data *
RUN chmod -R 777 /var/www/*
CMD bash /script/script.sh

#755


