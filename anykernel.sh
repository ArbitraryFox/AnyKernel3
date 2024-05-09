# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=Orokin Prime Kernel by Shubb-Niggurath
do.devicecheck=0
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=davinci
device.name2=davinciin
device.name3=
device.name4=
device.name5=
supported.versions=
'; } # end properties

# shell variables
BLOCK=/dev/block/bootdevice/by-name/boot;
IS_SLOT_DEVICE=0;
RAMDISK_COMPRESSION=auto;
PATCH_VBMETA_FLAG=auto;

## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;

## AnyKernel install
dump_boot;
write_boot;
## end install
