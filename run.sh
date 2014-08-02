#!/bin/sh

set -e

if [ ! -e /.initialized ]; then
    if [ -z $AFPD_LOGIN ]; then
        echo "no AFPD_LOGIN specified!"
        exit 1
    fi

    if [ -z $AFPD_PASSWORD ]; then
        echo "no AFPD_PASSWORD specified!"
        exit 1
    fi

    if [ -z $AFPD_NAME ]; then
        echo "no AFPD_NAME specified!"
        exit 1
    fi

    useradd $AFPD_LOGIN -M
    echo $AFPD_LOGIN:$AFPD_PASSWORD | chpasswd

    echo "- -tcp -noddp -uamlist uams_randnum.so,uams_dhx.so,uams_dhx2.so -nosavepassword" > /etc/netatalk/afpd.conf

    if [ -z $AFPD_SIZE_LIMIT ]; then
        echo "/share \"${AFPD_NAME}\" allow:$AFPD_LOGIN cnidscheme:dbd options:usedots,upriv,tm" > /etc/netatalk/AppleVolumes.default
    else
        echo "/share \"${AFPD_NAME}\" allow:$AFPD_LOGIN cnidscheme:dbd options:usedots,upriv,tm volsizelimit:$AFPD_SIZE_LIMIT" > /etc/netatalk/AppleVolumes.default
    fi

    touch /.initialized
fi

chown $AFPD_LOGIN /share

exec /usr/bin/supervisord -n
