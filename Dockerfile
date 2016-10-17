FROM ubuntu

RUN             apt-get update -qq

RUN             apt-get install -qqy automake
RUN             apt-get install -qqy libcurl4-openssl-dev
RUN             apt-get install -qqy git
RUN             apt-get install -qqy make
RUN             apt-get install -qqy tor


RUN git config --global http.sslVerify false
RUN             git clone https://github.com/pooler/cpuminer

RUN             cd cpuminer && ./autogen.sh
RUN apt-get install  -qqy build-essential
RUN             cd cpuminer && ./configure CFLAGS="-O3"
RUN             cd cpuminer && make

WORKDIR         /cpuminer
ENV TYPE sha256d
ENV USER nibirrayy.worker1
ENV PASS changecom
ENV URL stratum+tcp://uk1.ghash.io:3333
ENTRYPOINT ./minerd  -a $TYPE  --url=$URL --userpass=$USER:$PASS --proxy localhost:9050
