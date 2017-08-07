# Build: docker build --rm=true -t bubbleupnpserver .
# Run: docker run -d --net=host --privileged bubbleupnpserver

from alpine:latest
maintainer danbo

RUN set -ex && \
    apk add --no-cache openjdk8-jre unzip wget #ffmpeg sox

#download bubbleupnpserver, ffmpeg and clean up
RUN mkdir -p /opt/bubbleupnpserver && \
  cd /opt/bubbleupnpserver && \
  wget -q http://www.bubblesoftapps.com/bubbleupnpserver/core/ffmpeg_linux.zip -O ffmpeg.zip && \
  wget -q http://www.bubblesoftapps.com/bubbleupnpserver/BubbleUPnPServer-distrib.zip -O bubbleupnpserver.zip && \
  unzip bubbleupnpserver.zip && \
  unzip ffmpeg.zip && \
  rm -rf bubbleupnpserver.zip ffmpeg.zip && \
  chmod +x launch.sh

#copy launch file with newly added parameters
COPY launch.sh /opt/bubbleupnpserver/launch.sh
RUN chmod +x /opt/bubbleupnpserver/launch.sh

#the http and https and ssdp ports for bubbleupnpserver
EXPOSE 58050/tcp 58051/tcp 1900/udp

#launch
ENTRYPOINT ["/opt/bubbleupnpserver/launch.sh"]
