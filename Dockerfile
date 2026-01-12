# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-selkies:arch

# set version label
ARG BUILD_DATE
ARG VERSION
ARG PPSSPP_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="thelamer"

# app title
ENV TITLE=PPSSPP \
    PIXELFLUX_WAYLAND=true \
    NO_DECOR=true

RUN \
  echo "**** add icon ****" && \
  curl -o \
    /usr/share/selkies/www/icon.png \
    https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/ppsspp-logo.png && \
  echo "**** install packages ****" && \
  pacman -Sy --noconfirm --needed \
    ppsspp${PPSSPP_VERSION:+=$PPSSPP_VERSION} && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/* \
    /var/cache/pacman/pkg/* \
    /var/lib/pacman/sync/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3001
VOLUME /config
