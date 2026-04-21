#!/usr/bin/env python3

# https://gist.github.com/phrawzty/62540f146ee5e74ea1ab?permalink_comment_id=3362529#gistcomment-3362529
#
# Usage:
#
# $ python3 serve.py
#
# OR
#
# $ python3 serve.py <PORT>

import http.server as SimpleHTTPServer
import socketserver as SocketServer
import logging
import sys

try:
    PORT = int(sys.argv[1])
except:
    PORT = 8000

class GetHandler(SimpleHTTPServer.SimpleHTTPRequestHandler):

    def do_GET(self):
        logging.error(self.headers)
        SimpleHTTPServer.SimpleHTTPRequestHandler.do_GET(self)


Handler = GetHandler
httpd = SocketServer.TCPServer(('', PORT), Handler)

httpd.serve_forever()
