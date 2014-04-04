#! /usr/bin/env python

import urllib2, json, sys, pyperclip

# uri = raw_input("Enter URL: ");
uri = sys.argv[1]
jsonreq = json.dumps({'jsonrpc':'2.0', 'id':'qwer',
                      'method':'aria2.addUri',
                      'params':[[uri]]})
c = urllib2.urlopen('http://localhost:6800/jsonrpc', jsonreq)
c.read()
