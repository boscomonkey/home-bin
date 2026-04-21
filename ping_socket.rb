#!/usr/bin/env ruby

# TCP connectivity smoke test: open a socket to HOST [PORT], inspect it,
# and close. Exits non-zero if the connect fails.
#
# Usage: ping_socket.rb HOST [PORT=3000]

require 'socket'

host = ARGV[0] or raise "Usage: #{$0} HOST [PORT]"
port = ARGV[1] || 3000

s = TCPSocket.new(host, port)
puts s.inspect
s.close
