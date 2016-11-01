FROM phusion/passenger-full
MAINTAINER ZIMBITX community@zimbitx.com

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

RUN apt update
RUN apt-get -y install imagemagick gsfonts

ADD zimbitx /home/app/zimbitx
RUN chown -R app:app /home/app/zimbitx

USER app
ENV HOME /home/app

WORKDIR /home/app/zimbitx
RUN bundle install --without development test --path vendor/bundle

# RUN ./bin/init_config
ADD conf/rails-amqp.yml /home/app/zimbitx/config/amqp.yml
ADD conf/rails-database.yml /home/app/zimbitx/config/database.yml
ADD conf/rails-application.yml /home/app/zimbitx/config/application.yml
ADD conf/nginx-zimbitx-env.conf /etc/nginx/main.d/zimbitx-env.conf

USER root

RUN rm /etc/nginx/sites-enabled/default
ADD conf/nginx-zimbitx-with-ssl.conf /etc/nginx/sites-available/zimbitx
RUN ln -s /etc/nginx/sites-available/zimbitx /etc/nginx/sites-enabled/zimbitx

RUN mkdir /etc/nginx/ssl_keys/
ADD conf/ssl_keys/server.crt /etc/nginx/ssl_keys/server.crt
ADD conf/ssl_keys/server.key /etc/nginx/ssl_keys/server.key

RUN chown -R app:app /home/app/zimbitx/config

RUN rm -f /etc/service/nginx/down

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
