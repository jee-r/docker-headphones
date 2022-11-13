# docker-headphones

[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/j33r/headphones?style=flat-square)](https://microbadger.com/images/j33r/headphones)
![GitHub Workflow Status (branch)](https://img.shields.io/github/workflow/status/jee-r/docker-headphones/Deploy/main?style=flat-square)
[![Docker Pulls](https://img.shields.io/docker/pulls/j33r/headphones?style=flat-square)](https://hub.docker.com/r/j33r/headphones)
[![DockerHub](https://img.shields.io/badge/Dockerhub-j33r/headphones-%232496ED?logo=docker&style=flat-square)](https://hub.docker.com/r/j33r/headphones)
[![ghcr.io](https://img.shields.io/badge/ghrc%2Eio-jee%2D-r/headphones-%232496ED?logo=github&style=flat-square)](https://ghcr.io/jee-r/headphones)

A docker image for [Headphones](https://github.com/rembo10/headphones/) ![Headphones Logo](https://images.weserv.nl/?url=https://github.com/rembo10/headphones/raw/master/data/images/headphoneslogo.png&w=32&h=32)

## What is headphones?

From [https://github.com/rembo10/headphones](https://github.com/rembo10/headphones):

> Headphones is an automated music downloader for NZB and Torrent, written in Python. It supports SABnzbd, NZBget, Transmission, µTorrent, Deluge and Blackhole.

- Source code :
- Documentation : 
    - https://github.com/rembo10/headphones/wiki
    - https://github.com/rembo10/headphones/blob/master/API.md

## How to use these images

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

### Volume mounts


- `/config` : oore config directory contain `config.ini`
- `/torrents` : torrent watch and data directory  *[arbitrary]*
- `/usenet` :  usenet watch and data directory *[arbitrary]*
- `/Media/Music` : Tagged Music aftert post-process *[arbitrary]*

You should create directory before run the container otherwise directories are created by the docker deamon and owned by the root user

### Environment variables

To change the timezone of the container set the `TZ` environment variable. The full list of available options can be found on [Wikipedia](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones).

You can also set the `HOME` environment variable this is usefull to get in the right directory when you attach a shell in your docker container.


### Docker Compose

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

## Contributing :

You are welcome to contribute to this project, but read this before please.

### Issues

Found any issue or bug in the codebase? Have a great idea you want to propose ? 
You can help by submitting an issue to the Github repository. 

**Before opening a new issue, please check if the issue has not been already made by searching 
the issues**

### Questions

We would like to have discussions and general queries related to this repository.
you can reach me on [Libera irc server](https://libera.chat/) `/query jee`

### Pull requests

Before submitting a pull request, ensure that you go through the following:

- Ensure that there is no open or closed Pull Request corresponding to your submission to avoid duplication of effort.
- Create a new branch on your forked repo based on the **main branch** and make the changes in it. Example:

```
    git clone https://your_fork
    git checkout -B patch-N main
```

- Submit the pull request, provide informations (why/where/how) in the comments section

## License

This project is under the [GNU Generic Public License v3](https://github.com/jee-r/docker-headphones/blob/master/LICENSE) to allow free use while ensuring it stays open.
