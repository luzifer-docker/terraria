FROM ubuntu

ENV TERRARIA_VERISON=1308

RUN apt-get update \
 && apt-get install -y wget bash \
 && adduser gameserver

USER gameserver
ENV HOME /home/gameserver
ENV SERVER $HOME/terraria

RUN mkdir -p ${SERVER} \
 && wget -O - http://terraria.org/server/terraria-server-linux-${TERRARIA_VERISON}.tar.gz | tar -C ${SERVER} -xvz \
 && ln -s ${SERVER}/terraria-server-linux-* ${SERVER}/server

ADD config.ini ${SERVER}/config.ini.default
ADD start.sh ${SERVER}/start.sh

VOLUME /data
EXPOSE 7777/udp 7777

ENTRYPOINT ["/home/gameserver/terraria/start.sh"]
CMD ["--"]
