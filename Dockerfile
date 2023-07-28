FROM debian:latest
MAINTAINER Mauricio Medina
RUN apt-get update
RUN apt-get -y install sudo
RUN useradd -m debian 
RUN usermod -a -G sudo debian 
RUN echo "debian:hola123" | chpasswd
RUN apt-get -y install apache2
RUN apt-get -y install openssh-server
RUN mkdir /var/run/sshd
RUN systemctl enable apache2
RUN systemctl enable ssh
RUN service ssh start
RUN service apache2 start
WORKDIR /var/www/html/
VOLUME /var/www/html/
RUN mv index.html index.html.old
ADD https://www.ingenieria.unam.mx/ /var/www/html/index.html
RUN chmod 755 index.html
expose 80
expose 22
CMD /usr/sbin/apache2ctl -D FOREGROUND

