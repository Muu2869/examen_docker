# examen_docker
Repositorio para el examen de docker
#Bienvenido a esta imagen creada por un DockerFile
#A continuación se explicarán los comandos utilizados 
#para hacer funcionar la imagen.

#El archivo continene los siguientes comandos
#El comando from sirve para especificar el tipo de 
#sistema operativo en el cual se planea montar las
#aplicaciones, todo DockerFile debe comenzar con 
#esta instrucción.

FROM debian:latest

#El campo MAINTAINER se usa para especificar que
#perdona ha realizado el archivo.

MAINTAINER Mauricio Medina

#El comando RUN sirve para ejecutar comandos. 
#La mayoria se usa para realizar instalaciones de
#paquetes.
#Se instala la paquetería de sudo

RUN apt-get -y install sudo

#Se crea un usuario con su respectiva carpeta de /home

RUN useradd -m debian

#Se agrega el usuario creado al grupo de sudo

RUN usermod -a -G sudo debian

#Se le asigna un password al usuario

RUN echo "debian:hola123" | chpasswd

#Se actualizan las paqueterias.

RUN apt-get update

#Se instalan las herramientas de red.

RUN apt-get -y install net-tools

#Se instala el servicio de Apache para correr 
#servicios web.

RUN apt-get -y install apache2

#Se instala el servicio de SSH para conectarse
#al servidor.

RUN apt-get -y install openssh-server

#Se usa el comando ENTRYPOINT para iniciarlizar el servicio ssh

ENTRYPOINT service ssh start

#Con el comando WORKDIR especificamos que vamos a trabajar en en
#el directorio mencionado.

WORKDIR /var/www/html/

#Se crea un volumen para generar persistencia.

VOLUME /var/www/html/

#Se cambia el nombre del archivo index que viene por defecto
#al instalar apache.

RUN mv index.html index.html.old

#Con el comando ADD añadimos una página web y la guardamos
#como el nuevo index.

ADD https://www.ingenieria.unam.mx/ /var/www/html/index.html

#Se cambian los permisos para poder visualizar la pagina.

RUN chmod 755 index.html

#Se exponen los puertos 80 y 22 para SSH y HTTP
expose 80
expose 22

#Indicamos que se ejecute en segundo plano
CMD /usr/sbin/apache2ctl -D FOREGROUND
