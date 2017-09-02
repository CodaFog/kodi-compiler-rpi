## Kodi-rpi Dockerfile

This repository contains **Dockerfile** , based on a Raspbian image, for a dockerized compiled version of [Kodi](https://kodi.tv/download).
It get sources from the [Kodi Main Repository](https://github.com/xbmc/xbmc/) and compile a Kodi from it.
The steps are based on [NUNO SÉNICA Blog] (http://blog.nunosenica.com/compiling-kodi-and-building-deb-packages-raspbian/)

### Base Docker Image

* [resin/rpi-raspbian:jessie](https://hub.docker.com/r/resin/rpi-raspbian/)

### Installation

1. Install [Docker](https://www.docker.com/) on your Raspberry pi.

2. Create the directory used to store the kodi configuration files :
```
    mkdir -p /home/pi/kodi-compile-rpi/config
```
3. You can define a specific volume where Kodi can access :

    /home/pi/kodi-compile-rpi/data

### Usage
```
    docker run --name kodi-compile-rpi --device="/dev/tty0" --device="/dev/tty2" --device="/dev/fb0" --device="/dev/input" \
    --device="/dev/snd"  --device="/dev/vchiq" -v /var/run/dbus:/var/run/dbus  \
    -v /etc/localtime:/etc/localtime:ro -v /etc/timezone:/etc/timezone:ro \
    -v /home/pi/kodi-compile-rpi/config:/config/kodi  -v /home/pi/kodi-compile-rpi/data:/data \
    -p 8080:8080 -p 9777:9777/udp codafog/kodi-compile-rpi 
```
### Github

Githud Address : https://github.com/CodaFog/kodi-compile-rpi
