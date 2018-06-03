FROM debian:stretch

ENV TERRARIA_VERISON=1353 \
    DUMB_INIT_VERSION=1.2.1

RUN set -ex \
 && apt-get update \
 && apt-get install --no-install-recommends -y \
      bash \
      ca-certificates \
      curl \
      unzip \
 && useradd -m gameserver \
 && mkdir /data && chown gameserver: /data \
 && curl -sSfLo /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VERSION}/dumb-init_${DUMB_INIT_VERSION}_amd64 \
 && chmod +x /usr/local/bin/dumb-init \
 && rm -rf /var/cache/apk/*

USER gameserver
ENV HOME /home/gameserver
ENV SERVER $HOME/terraria

RUN set -ex \
 && mkdir -p ${SERVER} \
 && curl -sSLo /tmp/terraria.zip http://terraria.org/server/terraria-server-${TERRARIA_VERISON}.zip && unzip -d ${SERVER} /tmp/terraria.zip \
 && ln -s ${SERVER}/terraria-server-* ${SERVER}/server \
 && rm /tmp/terraria.zip

COPY config.ini ${SERVER}/config.ini.default
COPY start.sh ${SERVER}/start.sh

VOLUME /data
EXPOSE 7777/udp 7777

ENTRYPOINT ["/home/gameserver/terraria/start.sh"]
CMD ["--"]
