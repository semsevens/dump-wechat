#!/bin/bash

RES_DIR="/mnt/sdcard/tencent/MicroMsg"
MM_DIR="/data/data/com.tencent.mm"

today="$(date +'%Y-%m-%d_')"

echo "Starting rooted adb server..."
adb root

adb pull $MM_DIR/shared_prefs/system_config_prefs.xml 2>/dev/null

echo "Looking for user dir name..."
sleep 1  	# sometimes adb complains: device not found
# look for dirname which looks like md5 (32 alpha-numeric chars)
userList=$(adb ls $RES_DIR | cut -f 4 -d ' ' | sed 's/[^0-9a-z]//g' \
    | awk '{if (length() == 32) print}')
numUser=$(echo "$userList" | wc -l)
# choose the first user.
chooseUser=$(echo "$userList" | head -n1)
adb pull $MM_DIR/MicroMsg/$chooseUser/EnMicroMsg.db ${today}"EnMicroMsg.db"

