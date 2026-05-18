FROM debian:bullseye

RUN apt-get update\
	&& apt-get upgrade -y\
	&& apt-get install nginx -y\
	&& apt install vim -y\
	&& mkdir -p /etc/nginx/ssl\
	&& apt-get install openssl -y\
	&& openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=emunoz.42.fr/UID=emunoz"\
	&& mkdir -p /var/run/nginx
	
COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /var/www/html

RUN chown -R www-data:www-data /var/www/html

CMD [ "nginx", "-g", "daemon off;" ]