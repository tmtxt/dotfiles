#! /usr/bin/env python

import urllib2, json, base64, sys

torrent = base64.b64encode(open(sys.argv[1]).read())
jsonreq = json.dumps({'jsonrpc':'2.0', 'id':'asdf',
                      'method':'aria2.addTorrent', 'params':[torrent]})
c = urllib2.urlopen('http://localhost:6800/jsonrpc', jsonreq)
c.read()
