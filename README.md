```
docker build .

docker run -it --privileged -v /dev/bus/usb/:/dev/bus/usb/ f39bd8661df4 /bin/bash

uhd_usrp_probe

/usr/local/src/uhd/host/build/examples/rx_ascii_art_dft --rate 1000000 --freq 434000000
```
