#! /usr/bin/env sh

rsync -arvz --progress --delete ~/minecraft /Volumes/ramdisk/
cd /Volumes/ramdisk/minecraft
java -Xms512M -Xmx512M  -jar minecraft_server.1.7.4.jar
rsync -arvz --progress --delete /Volumes/ramdisk/minecraft ~/


