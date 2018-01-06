FROM ubuntu

ENV TERRARIA_VERISON=1344

RUN apt-get update \
 && apt-get install -y bash curl unzip \
 && adduser gameserver \
 && mkdir /data && chown gameserver: /data

USER gameserver
ENV HOME /home/gameserver
ENV SERVER $HOME/terraria

RUN mkdir -p ${SERVER} \
 && curl -sSLo /tmp/terraria.zip http://terraria.org/server/terraria-server-${TERRARIA_VERISON}.zip \
 && unzip -d ${SERVER} /tmp/terraria.zip \
 && ln -s ${SERVER}/terraria-server-* ${SERVER}/server

ADD config.ini ${SERVER}/config.ini.default
ADD start.sh ${SERVER}/start.sh

VOLUME /data
EXPOSE 7777/udp 7777

ENTRYPOINT ["/home/gameserver/terraria/start.sh"]
CMD ["--"]
