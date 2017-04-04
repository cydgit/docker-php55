FROM bylexus/apache-php55

RUN apt-get update && \
    apt-get install -y sendmail

COPY ./sendmail_config.sh .
RUN chmod +x sendmail_config.sh
#RUN sh sendmail_config.sh

RUN echo "memory_limit = 512M" > /etc/php5/apache2/php.ini

#CMD ["/usr/local/bin/run"]
