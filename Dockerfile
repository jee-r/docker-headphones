FROM alpine:3.15

LABEL name="docker-headphones" \
      maintainer="Jee jee@jeer.fr" \
      description="Headphones is an automated music downloader for NZB and Torrent, written in Python." \
      url="https://github.com/rembo10/headphones" \
      org.label-schema.vcs-url="https://github.com/jee-r/docker-headphones"

ARG SHNTOOL_VERSION=3.0.10

COPY rootfs /

RUN apk update && \
    apk upgrade && \
    apk add --no-cache --upgrade \
        git \
        musl \
        tzdata \
        python3 \
        py3-pip \
        ffmpeg \
        sox \
        openssl \
	    flac && \
    apk add --no-cache --upgrade --virtual=build-dependencies --upgrade \
        build-base \
        g++ \
        gcc \
        make && \
    cd /tmp && \
    mkdir /tmp/shntool && \
    wget http://shnutils.freeshell.org/shntool/dist/src/shntool-${SHNTOOL_VERSION}.tar.gz -O - | tar -xz -C /tmp/shntool --strip-components=1 && \
    git clone git://git.savannah.gnu.org/config.git && \
    cp /tmp/config/config.guess /tmp/config/config.sub /tmp/shntool/ && \
    patch -p0 /tmp/shntool/src/core_fileio.c  /tmp/patches/shntool-3.0.10-large-size.patch && \
    patch -p0 /tmp/shntool/src/core_mode.c   /tmp/patches/shntool-3.0.10-large-times.patch && \
    cd /tmp/shntool/ && \
    ./configure \
	   --infodir=/usr/share/info \
	   --localstatedir=/var \
	   --mandir=/usr/share/man \
	   --prefix=/usr \
	   --sysconfdir=/etc && \
    make && \
    make install && \
    mkdir /app && \
    chmod -R 777 /app && \
    apk del --purge build-dependencies build-dependencies && \
    rm -rf /tmp/*

WORKDIR /config

VOLUME /app
STOPSIGNAL SIGQUIT
ENTRYPOINT ["/usr/local/bin/entrypoint"]
