#!/bin/bash
set -e;

function join { local IFS=""; echo "$*"; }

# live boot system settings
loadkeys uk
timedatectl set-ntp true
timedatectl status

# drive partitions
DEVICE=/dev/sda
NEWLINE="\n"
ANSWERS=(
  o$NEWLINE   # Wipe
  n$NEWLINE   # New Partition
    $NEWLINE      # Default to primary
    $NEWLINE      # Default to partition 1
    $NEWLINE      # Default first sector
    +30G$NEWLINE  # 30GB
    a$NEWLINE     # Set bootable
  n$NEWLINE   # New Partition
    $NEWLINE      # Default to primary
    $NEWLINE      # Default to partition 2
    $NEWLINE      # Default first sector
    +2G$NEWLINE   # 2GB
    type$NEWLINE  # Set type
    $NEWLINE      # select partition 2
    82$NEWLINE    # choose SWAP
  n$NEWLINE   # New Partition
    $NEWLINE      # Default to primary
    $NEWLINE      # Default to partition 3
    $NEWLINE      # Default first sector
    $NEWLINE      # Default last sector
  w$NEWLINE   # Write
)

printf $(join "${ANSWERS[@]}") | sudo fdisk "$DEVICE"

mkfs.ext4 /dev/sda1
mkfs.ext4 /dev/sda3

mkswap /dev/sda2
swapon /dev/sda2

mount /dev/sda1 /mnt
mkdir /mnt/home
mount /dev/sda3 /mnt/home
