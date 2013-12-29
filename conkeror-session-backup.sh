#! /usr/bin/env sh

now=$(date +"%T")

cd "/Volumes/tmtxt/Library/Application Support/conkeror/Profiles/9i8y77go.default/sessions/"
git add auto-save
git commit -m "Session at $now"
