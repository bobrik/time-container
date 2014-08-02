FROM ubuntu:14.04

MAINTAINER Ian Babrou <ibobrik@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN sudo apt-get update
RUN sudo apt-get install -y netatalk avahi-daemon supervisor

RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ADD ./run.sh /run.sh

EXPOSE 548

CMD ["/bin/sh", "/run.sh"]
