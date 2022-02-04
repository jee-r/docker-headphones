# docker-headphones

[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/j33r/headphones?style=flat-square)](https://microbadger.com/images/j33r/headphones)
[![Docker Pulls](https://img.shields.io/docker/pulls/j33r/headphones?style=flat-square)](https://hub.docker.com/r/j33r/headphones)
[![DockerHub](https://img.shields.io/badge/Dockerhub-j33r/headphones-%232496ED?logo=docker&style=flat-square)](https://hub.docker.com/r/j33r/headphones)
[![ghcr.io](https://img.shields.io/badge/ghrc%2Eio-jee%2D-r/headphones-%232496ED?logo=github&style=flat-square)](https://ghcr.io/jee-r/headphones)

A docker image for [Headphones](https://github.com/rembo10/headphones/)

![Headphones Logo](https:////images.weserv.nl/?url=https://github.com/rembo10/headphones/raw/master/data/images/headphoneslogo.png&w=32&h=32)


# Supported tags

| Tags | Size | Platforms | Build |
|-|-|-|-|
| `latest`, `master` | ![](https://img.shields.io/docker/image-size/j33r/headphones/latest?style=flat-square) | `amd64` | ![GitHub Workflow Status (branch)](https://img.shields.io/github/workflow/status/jee-r/docker-headphones/Deploy/master?style=flat-square) 
| `dev` | ![](https://img.shields.io/docker/image-size/j33r/headphones/dev?style=flat-square)  | `amd64`| ![GitHub Workflow Status (branch)](https://img.shields.io/github/workflow/status/jee-r/docker-headphones/Deploy/dev?style=flat-square)

# What is headphones?

From [https://github.com/rembo10/headphones](https://github.com/rembo10/headphones):

> Headphones is an automated music downloader for NZB and Torrent, written in Python. It supports SABnzbd, NZBget, Transmission, µTorrent, Deluge and Blackhole.

- Source code :
- Documentation : 
    - https://github.com/rembo10/headphones/wiki
    - https://github.com/rembo10/headphones/blob/master/API.md

# How to use these images

```bash
docker run --rm  -ti \                           
    --name headphones \
    --user $(id -u):$(id -g) \
    --volume ${PWD}/app:/app \
    --volume /etc/localtime:/etc/localtime:ro \
    --volume ${PWD}/config:/config \
    --volume ${PWD}/torrents:/torrents \
    --volume ${PWD}/usenet:/usenet \
    --volume ${PWD}/Media:/Media \
    --publish 8181:8181 \
    headphones:build
```    

## Volume mounts


- `/config` : oore config directory contain `config.ini`
- `/torrents` : torrent watch and data directory  *[arbitrary]*
- `/usenet` :  usenet watch and data directory *[arbitrary]*
- `/Media/Music` : Tagged Music aftert post-process *[arbitrary]*

You should create directory before run the container otherwise directories are created by the docker deamon and owned by the root user

## Environment variables

To change the timezone of the container set the `TZ` environment variable. The full list of available options can be found on [Wikipedia](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones).

You can also set the `HOME` environment variable this is usefull to get in the right directory when you attach a shell in your docker container.


## Docker Compose

[`docker-compose`](https://docs.docker.com/compose/) can help with defining the `docker run` config in a repeatable way rather than ensuring you always pass the same CLI arguments.

Here's an example `docker-compose.yml` config:

```yaml
version: "3"

services:
  headphones:
    image: j33r/headphones:latest    
    user: "${UID:-1000}:${GID:-1000}"
    restart: unless-stopped
    environment:
      - HOME=/app
      - TZ=Europe/Paris
    volumes:
      - ./config:/config \
      - ./torrents:/torrents \
      - ./usenet:/usenet \
      - ./Media:/Media
      - /etc/localtime:/etc/localtime:ro
    ports:
      - 8181:8181
```

# License

This project is under the [GNU Generic Public License v3](https://github.com/jee-r/docker-headphones/blob/master/LICENSE) to allow free use while ensuring it stays open.
