#!/system/bin/sh
#
# Copyright (C) 2020 TheHitMan7 (Kartik Verma)
#
# BiTGApps Addon Installer Script

# Clone this script using following commands
# curl https://raw.githubusercontent.com/BiTGApps/BiTGApps/master/addon/script/addon.sh > /cache/addon.sh
#
# Install addon using following commands
# su
# chmod +x /cache/addon.sh
# ./cache/addon.sh

# Set shell defaults
CYAN='\033[0;46m'
RED='\033[0;41m'
NC='\033[0m'

# Android SDK check
android_sdk=`getprop ro.build.version.sdk`
android_version=`getprop ro.build.version.release`

if [ "$android_sdk" == "29" ] || [ "$android_sdk" == "28" ]; then
  mount -o rw,remount /
else
  mount -o rw,remount /system
fi;

# Installation layout
echo "=========================="
busybox echo -e "${RED} BiTGApps Addon Installer ${NC}"
echo "=========================="
INPUT='Please enter your choice: '
options=("Assistant" "Wellbeing" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Assistant")
            CYAN='\033[0;46m'
            NC='\033[0m'
            busybox echo -e "${CYAN} Installing Google Assistant ${NC}"
            rm -rf /cache/prebuilt_Velvet.tar.xz 2>/dev/null;
            rm -rf /system/priv-app/Velvet 2>/dev/null;
            rm -rf /system/product/priv-app/Velvet 2>/dev/null;
            busybox wget https://github.com/BiTGApps/BiTGApps/raw/master/addon/prebuilt/prebuilt_Velvet.tar.xz -O /cache/prebuilt_Velvet.tar.xz 2>/dev/null;
            busybox tar tvf /cache/prebuilt_Velvet.tar.xz
            if [ "$android_sdk" == "29" ]; then
              busybox tar -xf /cache/prebuilt_Velvet.tar.xz -C /system/product/priv-app 2>/dev/null;
              chmod 0755 /system/product/priv-app/Velvet
              chmod 0644 /system/product/priv-app/Velvet/Velvet.apk
              chcon -h u:object_r:system_file:s0 "/system/product/priv-app/Velvet/Velvet.apk";
            else
              busybox tar -xf /cache/prebuilt_Velvet.tar.xz -C /system/priv-app 2>/dev/null;
              chmod 0755 /system/priv-app/Velvet
              chmod 0644 /system/priv-app/Velvet/Velvet.apk
              chcon -h u:object_r:system_file:s0 "/system/priv-app/Velvet/Velvet.apk";
            fi;
            busybox echo -e "${CYAN} Installation Finished ${NC}"
            break
            ;;
        "Wellbeing")
            busybox echo -e "${CYAN} Installing Google's Wellbeing ${NC}"
            rm -rf /cache/prebuilt_Wellbeing.tar.xz 2>/dev/null;
            rm -rf /system/priv-app/Wellbeing 2>/dev/null;
            rm -rf /system/priv-app/WellbeingPrebuilt 2>/dev/null;
            rm -rf /system/product/priv-app/Wellbeing 2>/dev/null;
            rm -rf /system/product/priv-app/WellbeingPrebuilt 2>/dev/null;
            busybox wget https://github.com/BiTGApps/BiTGApps/raw/master/addon/prebuilt/prebuilt_Wellbeing.tar.xz -O /cache/prebuilt_Wellbeing.tar.xz 2>/dev/null;
            busybox tar tvf /cache/prebuilt_Wellbeing.tar.xz
            if [ "$android_sdk" == "29" ]; then
              busybox tar -xf /cache/prebuilt_Wellbeing.tar.xz -C /system/product/priv-app 2>/dev/null;
              chmod 0755 /system/product/priv-app/WellbeingPrebuilt
              chmod 0644 /system/product/priv-app/WellbeingPrebuilt/WellbeingPrebuilt.apk
              chcon -h u:object_r:system_file:s0 "/system/product/priv-app/WellbeingPrebuilt/WellbeingPrebuilt.apk";
            else
              busybox tar -xf /cache/prebuilt_Wellbeing.tar.xz -C /system/priv-app 2>/dev/null;
              chmod 0755 /system/priv-app/WellbeingPrebuilt
              chmod 0644 /system/priv-app/WellbeingPrebuilt/WellbeingPrebuilt.apk
              chcon -h u:object_r:system_file:s0 "/system/priv-app/WellbeingPrebuilt/WellbeingPrebuilt.apk";
            fi;
            busybox echo -e "${CYAN} Installation Finished ${NC}"
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
