USB_DRIVE_NAME=$1
if [ -z "$USB_DRIVE_NAME" ];
then
  echo "USB Drive name empty - pass the name as the first parameter."
  echo "To view the list of connected devices run: [diskutil list]"
  echo "Then run: [./download-iso.sh /dev/disk2] (replacing disk2 with the correct name)"
  exit 1
fi

curl -o arch.iso http://mirror.rackspace.com/archlinux/iso/2020.02.01/archlinux-2020.02.01-x86_64.iso
SHASUM=$(shasum ./arch.iso | cut -d " " -f1)
EXPECTED_SHASUM=c71fdff7f793888d7f53aa5e0685602e3167825c
if [ "$SHASUM" != "$EXPECTED_SHASUM" ];
then
  echo "The downloaded file's SHA1 SUM was incorrect:"
  echo "Expected:    '$EXPECTED_SHASUM'"
  echo "Actual:      '$SHASUM'"
  exit 1
fi

echo "File downloaded successfully"

dd bs=4m if=arch.iso of=$USB_DRIVE_NAME conv=sync
