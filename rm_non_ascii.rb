#!/usr/bin/env ruby

# Removes non-ASCII characters from ARGF and outputs to STDOUT
#
# http://stackoverflow.com/questions/1268289/how-to-get-rid-of-non-ascii-characters-in-ruby

# See String#encode
encoding_options = {
  :invalid           => :replace,  # Replace invalid byte sequences
  :undef             => :replace,  # Replace anything not defined in ASCII
  :replace           => '',        # Use a blank for those replacements
  :universal_newline => true       # Always break lines with \n
}

input = ARGF.read
output = input.encode(Encoding.find('ASCII'), encoding_options)
STDOUT << output
