FROM alpine:3.6

RUN apk update && \
    apk add --no-cache --virtual .build-deps ca-certificates curl \
    apk add --no-cache openssh libnet-dev libpcap-dev libcap-dev git gcc libffi-dev openssl-dev musl-dev \
    && curl -fSL https://github.com/goproxy0/goproxy/releases/download/r1623/goproxy-vps_linux_amd64-r266.tar.xz | tar xJ \
    && rm -rf goproxy-vps_linux_amd64-r266.tar.xz
    
RUN git clone https://github.com/snooda/net-speeder.git net-speeder
WORKDIR net-speeder
RUN sh build.sh
RUN mv net_speeder /usr/local/bin/
RUN chmod +x /usr/local/bin/net_speeder

ENV CONFIG_FILE_URL = https://pastbin/raw/....

ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT  /entrypoint.sh 

EXPOSE 8443
