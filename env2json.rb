#!/usr/bin/env ruby

require 'json'

sorted_hash = ENV.keys.sort.map { |key| [key, ENV[key]] }.to_h
puts JSON.pretty_generate(sorted_hash)
