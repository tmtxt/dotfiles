cd ~/Downloads
touch session.txt
aria2c --enable-rpc --rpc-listen-all --save-session=session.txt -isession.txt -x16 -k1M
