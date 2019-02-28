meshnode
========

Experimental Ad-Hoc Mesh node that runs batman-adv, Cjdns and Yggdrasil.

## Setup repository and Buildroot
Clone repository and enter it:
```
git clone git@github.com:ltumesh/meshnode.git --recursive && cd meshnode
git lfs install
git lfs pull
```
Set `BR2_EXTERNAL` tree to meshnode, and set number of threads to utilize:
```
export BR2_EXTERNAL="$(pwd)/meshnode"
export BR2_JLEVEL="$(nproc)"
```

Enter Buildroot:
```
cd buildroot
```

## Add SSH public key
To access the Meshnode, add your SSH key to the overlay:
```
mkdir -p $BR2_EXTERNAL/overlay/root/.ssh && \
cp $HOME/.ssh/id_rsa.pub $_/authorized_keys
```

## Creating and flashing image
### Raspberry Pi 2
Use Raspberry Pi 2 `defconfig`:
```
make raspberrypi2_defconfig
```

Compile and create image:
```
make
```

Flash it to memory card (replace `<device>` with yours):
```
dd if=output/images/sdcard.img of=/dev/<device>
```
