ARG VERSION="3.1.2-buster"
FROM ruby:${VERSION}

ARG RAILS_ROOT=/Rails

RUN set -x \
&&  gem install bundler -N

RUN set -x \
  && apt-get update \
  && apt-get install -y nodejs locales default-mysql-client

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
&& bundle install --jobs=4

RUN set -x \
&& chmod o+x ../entrypoint.sh

CMD ["/bin/bash", "-c", "/entrypoint.sh"]