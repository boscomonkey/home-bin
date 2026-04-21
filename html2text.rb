#!/usr/bin/env ruby

# Convert HTML on stdin/ARGF to plain text using Nokogiri.
#
# Usage: html2text.rb < page.html

require 'rubygems'
require 'nokogiri'

puts Nokogiri::HTML(ARGF.read).text
