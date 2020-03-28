meshnode
========

Experimental Ad-Hoc Mesh node that runs batman-adv, ~~cjdns~~ and Yggdrasil
(cjdns isn't supported yet).

## Setup repository and Buildroot

Clone repository and enter it:

```bash
git clone git@github.com:ltumesh/meshnode.git --recursive && cd meshnode
```

Set `BR2_EXTERNAL` tree to meshnode, and set number of threads to utilize:

```bash
export BR2_EXTERNAL="$(pwd)/meshnode"
export BR2_JLEVEL="$(nproc)"
```

Enter Buildroot:

```bash
cd buildroot
```

## Add SSH public key
To access the Meshnode, add your SSH key to the overlay:

```bash
mkdir -p $BR2_EXTERNAL/overlay/root/.ssh && \
cp $HOME/.ssh/id_rsa.pub $_/authorized_keys
```

## Creating and flashing image
#### Raspberry Pi 2

Use Raspberry Pi 2 `defconfig`:

```bash
make raspberrypi2_defconfig
```

Compile and create image:

```bash
make
```

Flash it to memory card (replace `<device>` with yours):

```bash
dd if=output/images/sdcard.img of=/dev/<device>
```
