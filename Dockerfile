FROM ubuntu:22.04
LABEL maintainer="phelpsw@gmail.com"

# This will make apt-get install without question
ARG         DEBIAN_FRONTEND=noninteractive
ARG         UHD_TAG=v4.4.0.0
# MAKEWIDTH is the number of compile threads to use, default is 4
ARG         MAKEWIDTH=16

# Install dependencies per https://files.ettus.com/manual/page_build_guide.html
RUN apt-get update && \
    apt-get -y install -q autoconf automake build-essential ccache cmake cpufrequtils doxygen ethtool \
    g++ git inetutils-tools libboost-all-dev libncurses5 libncurses5-dev libusb-1.0-0 libusb-1.0-0-dev \
    libusb-dev python3-dev python3-mako python3-numpy python3-requests python3-scipy python3-setuptools \
    python3-ruamel.yaml 

RUN          mkdir -p /usr/local/src
RUN          git clone https://github.com/EttusResearch/uhd.git /usr/local/src/uhd
RUN          cd /usr/local/src/uhd/ && git checkout $UHD_TAG
RUN          mkdir -p /usr/local/src/uhd/host/build
WORKDIR      /usr/local/src/uhd/host/build
RUN          cmake ../ -DENABLE_EXAMPLES=true -DENABLE_UTILS=true -DUHD_RELEASE_MODE=release -DCMAKE_INSTALL_PREFIX=/usr
RUN          make -j $MAKEWIDTH
RUN          make install
RUN          uhd_images_downloader
WORKDIR      /