FROM debian:bullseye

# Installer MariaDB
RUN apt-get update && apt-get upgrade -y && apt-get install mariadb-server -y

# Copier les fichiers nécessaires
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY conf/script.sh /usr/local/bin/script.sh

# Donner les permissions d'exécution au script
RUN chmod +x /usr/local/bin/script.sh

EXPOSE 3306

CMD ["/usr/local/bin/script.sh"]
