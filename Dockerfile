ARG VERSION="2.7.1-buster"
FROM ruby:${VERSION}

ARG RAILS_ROOT=/Rails

RUN set -x \
&&  gem install bundler -N

RUN set -x \
  && apt-get update \
  && apt-get install -y nodejs locales default-mysql-client

# RUN set -x \
#   && apt-get update \
#   && apt-get install -y nodejs locales lsb-release \
#   && apt remove -y libmariadb-dev-compat libmariadb-dev

# RUN wget https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-common_8.0.20-1debian10_amd64.deb \
#     https://dev.mysql.com/get/Downloads/MySQL-8.0/libmysqlclient21_8.0.20-1debian10_amd64.deb \
#     https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-community-client-core_8.0.20-1debian10_amd64.deb \
#     https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-community-client_8.0.20-1debian10_amd64.deb \
#     https://dev.mysql.com/get/Downloads/MySQL-8.0/libmysqlclient-dev_8.0.20-1debian10_amd64.deb

# RUN dpkg -i mysql-common_8.0.20-1debian10_amd64.deb \
#     libmysqlclient21_8.0.20-1debian10_amd64.deb \
#     mysql-community-client-core_8.0.20-1debian10_amd64.deb \
#     mysql-community-client_8.0.20-1debian10_amd64.deb \
#     libmysqlclient-dev_8.0.20-1debian10_amd64.deb

ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.7.3/wait /wait 

RUN chmod +x /wait

RUN set -x \
&& echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen \
&& locale-gen

ENV LC_ALL ja_JP.UTF-8

WORKDIR ${RAILS_ROOT}
COPY ./Rails/Gemfile ./Gemfile
COPY ./Rails/Gemfile.lock ./Gemfile.lock
COPY ./entrypoint.sh ../entrypoint.sh

RUN set -x \
&& bundle install --path vendor/bundle --jobs=4

RUN set -x \
&& chmod o+x ../entrypoint.sh

CMD ["/bin/bash", "-c", "/entrypoint.sh"]