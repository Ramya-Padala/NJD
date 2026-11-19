FROM httpd:latest
COPY index.html /usr/share/apache2/html/index.html
EXPOSE 80
