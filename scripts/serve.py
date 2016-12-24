#!/usr/bin/env python2

import SimpleHTTPServer
import SocketServer


class RequestHandler(SimpleHTTPServer.SimpleHTTPRequestHandler):
    def do_GET(self):
        if self.path.endswith('/'):
            self.path += 'index.html'
        if '.' not in self.path:
            self.path += '.html'
        return SimpleHTTPServer.SimpleHTTPRequestHandler.do_GET(self)


server = SocketServer.TCPServer(('0.0.0.0', 8005), RequestHandler)
server.serve_forever()
