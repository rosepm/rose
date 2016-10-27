FROM debian:latest

MAINTAINER Sam Hart version: 0.1

RUN apt-get update && apt-get install -y git
RUN git clone https://github.com/rosepm/rose.git /root/rose
RUN cd /root/rose && ./install.sh

ENV PATH /root/bin:$PATH
ENV ROSELIB_PATH /root/lib/rose

CMD ["/bin/bash" ]
