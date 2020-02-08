# arch-installer
Scripts to install Arch Linux from a live boot USB.

## Usage

### Stage 1: Create the live boot drive

1. Insert a USB drive
1. `cd ./iso`
1. `./download-iso.sh /dev/$USB_DRIVE_NAME`

### Stage 2: Live boot

1. Insert the USB into a laptop and boot Arch Linux.
1. `pacman -Sy git`
1. `git clone https://github.com/hofnarwillie/arch-installer.git`

