#!/bin/sh
# Script installs NixOS with Chrome in kiosk mode in a Cage environment
echo "NixOS-Installer"
echo "Execute as Superuser and be careful using sgdisk!"

# Delete /dev/sda and create 2 new partitions (2GB EFI, rest root)
sgdisk -og /dev/sda
sgdisk -n 1:2048:4196351 -t 1:ef00 -c 1:NIXBOOT /dev/sda
sgdisk -n 2:4196352:0 -t 2:8300 -c 2:NIXROOT /dev/sda

sgdisk -p /dev/sda

mkfs.fat -F 32 /dev/sda1
fatlabel /dev/sda1 NIXBOOT
mkfs.ext4 /dev/sda2 -L NIXROOT

mount /dev/disk/by-label/NIXROOT /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/NIXBOOT /mnt/boot

# Create configs and copy prepared config
nixos-generate-config root /mnt
cp /iso/configuration.nix /mnt/etc/nixos
cd /mnt

# set proxy if necessary or delete this part ,)
proxy="http://FooBar/:Port"
export http_proxy="$proxy"
export https_proxy="$proxy"
export HTTP_PROXY="$proxy"
export HTTPS_PROXY="$proxy"

nixos-install
