# https://docs.j7k6.org/windows-10-pxe-installation/

if [ ! -f KB3AIK_EN.iso_winpe.iso ]; then
  sudo apt-get install -y samba genisoimage wimtools cabextract
  sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu bionic main universe restricted multiverse"
  [ ! -f KB3AIK_EN.iso ] && wget https://download.microsoft.com/download/8/E/9/8E9BBC64-E6F8-457C-9B8D-F6C9A16E6D6A/KB3AIK_EN.iso
  sudo mount KB3AIK_EN.iso /mnt/waik
  [ ! -d /var/lib/tftpboot/1/win ] && sudo mkdir -p /var/lib/tftpboot/1/win
  mkwinpeimg --iso --arch=amd64 --waik-dir=/mnt/waik /var/lib/tftpboot/1/win/KB3AIK_EN.iso_winpe.iso
  sudo umount /mnt/waik
fi
