FROM resin/rpi-raspbian:jessie

RUN [ "cross-build-start" ]

# CPU argument for Raspberry Pi 2 or 3
ARG CPU=cortex-a7
# CPU argument for Raspberry Pi 0
#ARG CPU=arm1176jzf-s

#RUN apt-get clean && apt-get update && apt-get install --no-install-recommends -y apt-utils wget && rm -rf /var/lib/apt/lists/*
RUN apt-get clean && apt-get update && apt-get install --no-install-recommends -y apt-utils wget && apt-get clean

# add pipplware repo
RUN echo "deb http://pipplware.pplware.pt/pipplware/dists/jessie/main/binary /" > /etc/apt/sources.list.d/pipplware.list \
    && echo "deb http://pipplware.pplware.pt/pipplware/dists/jessie/armv7/binary /" >> /etc/apt/sources.list.d/pipplware.list \
    && wget -qO- http://pipplware.pplware.pt/pipplware/key.asc | apt-key add -

# install BUILD dependancies
ARG BUILD_DEPENDENCIES="git wget curl devscripts build-essential \
  autoconf automake autotools-dev cmake ccache \
  default-jre gawk gdc gperf libasound2-dev libass-dev \
  libavahi-client-dev libavahi-common-dev libbluetooth-dev libbluray-dev \
  libboost-dev libboost-thread-dev libbz2-dev libcdio-dev libcurl4-openssl-dev \
  libcwiid-dev libdbus-1-dev libenca-dev libflac-dev libfontconfig-dev \
  libfreetype6-dev libfribidi-dev libgcrypt-dev libgl1-mesa-dev libglew-dev \
  libglu1-mesa-dev libgnutls28-dev libgpg-error-dev libiso9660-dev libjasper-dev \
  libjpeg-dev libltdl-dev liblzo2-dev libmad0-dev libmicrohttpd-dev libmodplug-dev \
  libmp3lame-dev libmpeg2-4-dev libmysqlclient-dev libnfs-dev libogg-dev libpcre3-dev \
  libplist-dev libpng12-dev libpulse-dev librtmp-dev libsamplerate-dev libsdl2-dev \
  libsmbclient-dev libsqlite3-dev libssh-dev libssl-dev libtag1-dev libtiff5-dev \
  libtinyxml-dev libtool libudev-dev libva-dev libvdpau-dev libvorbis-dev libxmu-dev \
  libxrandr-dev libxslt1-dev libxt-dev libyajl-dev nasm python-dev python-imaging swig \
  uuid-dev yasm zip zlib1g-dev bluez libspeex-dev libspeexdsp-dev libdvdread-dev libdvdnav-dev \
  libcec4-dev libcrossguid-dev libgif-dev libbluray-dev libshairplay-dev libraspberrypi0"

RUN apt-get install --no-install-recommends -y $BUILD_DEPENDENCIES && apt-get clean

# get sources with git
RUN mkdir -p /src/kodi/\
&& git clone --depth 1 git://github.com/xbmc/xbmc.git --branch Krypton /src/kodi 

WORKDIR /src/kodi/

# Use a script to compile and build the kodi package (for kodi-agile)
RUN wget -q https://raw.githubusercontent.com/nsenica/xbmc/krypton_new/tools/Linux/packaging/build_rpi_debian_packages.sh \
  && chmod +x build_rpi_debian_packages.sh

#RUN ./build_rpi_debian_packages.sh

RUN [ "cross-build-end" ]
