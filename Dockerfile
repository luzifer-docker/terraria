FROM debian:stretch

ENV TERRARIA_VERISON=1353 \
    DUMB_INIT_VERSION=1.2.1 \
    GOSU_VERSION=1.10 \
    TERRARIA_DOCKER_VERSION=v0.2.0 \
    HOME=/home/gameserver \
    SERVER=/home/gameserver/terraria

RUN set -ex \
 && apt-get update \
 && apt-get install --no-install-recommends -y \
      bash \
      ca-certificates \
      curl \
      unzip \
 && useradd -m gameserver \
 && mkdir /data && chown gameserver: /data \
 && curl -sSfLo /usr/local/bin/dumb-init "https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VERSION}/dumb-init_${DUMB_INIT_VERSION}_amd64" \
 && curl -sSfLo /usr/local/bin/gosu https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64 \
 && curl -sSfL "https://github.com/Luzifer/terraria-docker/releases/download/${TERRARIA_DOCKER_VERSION}/terraria-docker_linux_amd64.tar.gz" | tar -xz -C /usr/local/bin \
 && chmod +x \
      /usr/local/bin/dumb-init \
      /usr/local/bin/gosu \
 && mkdir -p ${SERVER} \
 && curl -sSfLo /tmp/terraria.zip "http://terraria.org/server/terraria-server-${TERRARIA_VERISON}.zip" \
 && unzip -d ${SERVER} /tmp/terraria.zip \
 && chown -R gameserver:gameserver ${SERVER} \
 && rm /tmp/terraria.zip \
 && rm -rf /var/lib/apt/lists/*

COPY config.ini ${SERVER}/config.ini.default
COPY start.sh ${SERVER}/start.sh
COPY terraria_cmd.sh /usr/local/bin/terraria_cmd

VOLUME /data
EXPOSE 7777/udp 7777

ENTRYPOINT ["/home/gameserver/terraria/start.sh"]
CMD ["--"]
