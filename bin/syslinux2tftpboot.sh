#!/bin/bash 

# https://www.syslinux.org/wiki/index.php?title=PXELINUX#Custom_Menu_Example_with_sub-menus


MKTMPDIR=`mktemp -d`
pushd $MKTMPDIR


# https://mirrors.edge.kernel.org/pub/linux/utils/boot/syslinux/syslinux-6.03.tar.xz
# https://mirrors.edge.kernel.org/pub/linux/utils/boot/syslinux/Testing/6.04/syslinux-6.04-pre1.tar.xz
SYSLINUXURL=https://mirrors.edge.kernel.org/pub/linux/utils/boot/syslinux/Testing/6.04/syslinux-6.04-pre1.tar.xz
SYSLINUXBASE=`basename syslinux-6.04-pre1 .tar.xz`

[ ! -f $SYSLINUXBASE.tar.xz ] && wget $SYSLINUXURL
ls $SYSLINUXBASE.tar.xz
tar xf $SYSLINUXBASE.tar.xz

cd $SYSLINUXBASE


TFTPBOOTDIR=../tftpboot 
BIOSDIR=$TFTPBOOTDIR
[ ! -d $BIOSDIR ] && mkdir -p $BIOSDIR
# EFI32DIR=$TFTPBOOTDIR/efi32
# [ ! -d $EFI32DIR ] && mkdir -p $EFI32DIR
EFI64DIR=$TFTPBOOTDIR/efi64
[ ! -d $EFI64DIR ] && mkdir -p $EFI64DIR


# Legacy BIOS
cp ./bios/core/pxelinux.0 $BIOSDIR
cp ./bios/memdisk/memdisk $BIOSDIR
cp ./bios/com32/elflink/ldlinux/ldlinux.c32 $BIOSDIR
cp ./bios/com32/menu/menu.c32 $BIOSDIR
cp ./bios/com32/libutil/libutil.c32 $BIOSDIR
cp ./bios/com32/mboot/mboot.c32 $BIOSDIR

# cp ./efi32/efi/syslinux.efi $EFI32DIR
# #cp ./efi32/efi/syslinux.efi $EFI32DIR/bootia32.efi
# cp ./efi32/com32/elflink/ldlinux/ldlinux.e32 $EFI32DIR
# cp ./efi32/com32/menu/menu.c32 $EFI32DIR
# cp ./efi32/com32/libutil/libutil.c32 $EFI32DIR

cp ./efi64/efi/syslinux.efi $EFI64DIR
#cp ./efi64/efi/syslinux.efi $EFI64DIR/bootx64.efi
cp ./efi64/com32/elflink/ldlinux/ldlinux.e64 $EFI64DIR
cp ./efi64/com32/menu/menu.c32 $EFI64DIR
cp ./efi64/com32/libutil/libutil.c32 $EFI64DIR
cp ./efi64/com32/mboot/mboot.c32 $EFI64DIR


popd


ls -R $MKTMPDIR/tftpboot

echo "$0 Do the following manually:"
echo "$0 cp -r $MKTMPDIR/tftpboot/* /var/lib/tftpboot/"
echo "$0 rm -r $MKTMPDIR"


exit
