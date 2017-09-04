FROM codafog/kodi-compiler-rpi:base

RUN [ "cross-build-start" ]

# CPU argument for Raspberry Pi 2 or 3
ARG CPU=cortex-a7
# CPU argument for Raspberry Pi 0
#ARG CPU=arm1176jzf-s
ARG GITURL="git://github.com/xbmc/xbmc.git"
ARG GITBRANCH="Krypton"


# get sources with git
RUN mkdir -p /src/kodi/ \
&& git clone --depth 1 "$GITURL" --branch "$GITBRANCH" /src/kodi

WORKDIR /src/kodi/

# Download the script to compile and build the kodi package
RUN wget -q https://raw.githubusercontent.com/nsenica/xbmc/krypton_new/tools/Linux/packaging/build_rpi_debian_packages.sh \
  && chmod +x build_rpi_debian_packages.sh

# compile Kodi
RUN ./build_rpi_debian_packages.sh

# install debian packages
RUN dpkg -i packages/*.deb

# uncomment if you want to enable webserver and remote control settings
COPY "./files-to-copy-to-image/settings.xml" "/usr/share/kodi/system/settings"

# ports and volumes
VOLUME /config/kodi
VOLUME /data
EXPOSE 8080 9777/udp

CMD ["bash", "/usr/bin/kodi-standalone"]


RUN [ "cross-build-end" ]
