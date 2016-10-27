FROM dock0/arch:latest

MAINTAINER Sam Hart version: 0.1

RUN pacman -Sy --noconfirm git man
RUN git clone https://github.com/rosepm/rose.git /root/rose
RUN cd /root/rose && ./install.sh

ENV PATH /root/bin:$PATH
ENV ROSELIB_PATH /root/lib/rose

CMD ["/bin/bash" ]
