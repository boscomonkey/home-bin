#!/usr/bin/env ruby

# Re-emit a YAML document with bare `on` / `off` scalars quoted, so they
# survive as strings instead of being coerced to booleans (a YAML 1.1
# gotcha). Reads from stdin/ARGF, writes to stdout.
#
# Usage: rewrite_yaml.rb < input.yml > output.yml

require 'yaml'

str = ARGF.read
ydoc = YAML.load(str)
ydoc.select{ |node| node.is_a?(Psych::Nodes::Scalar) &&
             %w(on off).include?(node.value) }
  .each{|node| node.quoted = true }

converter = Psych::Visitors::ToRuby.create
obj = converter.visit_Psych_Nodes_Document(ydoc)

puts obj.to_yaml
