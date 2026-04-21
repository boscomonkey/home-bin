#!/usr/bin/env ruby
# frozen_string_literal: true

# Reads a YAML file from STDIN, and re-outputs the read object in a
# sorted manner.
#
# Sorting the object facilitates running "diff" on existing YAML files
# to reveal differences.
#
# Usage:
#	yaml_sort.rb database.yaml

require 'yaml'

# Sorts an object recursively by key while preserving array element order.
#
class RecursiveSort
  def self.parse_string(str)
    ydoc = YAML.parse(str)
    ydoc.select{ |node| node.is_a?(Psych::Nodes::Scalar) &&
                 %w(on off).include?(node.value) }
      .each{|node| node.quoted = true }

    converter = Psych::Visitors::ToRuby.create
    converter.visit_Psych_Nodes_Document(ydoc)
  end

  def self.sort_object(obj)
    case obj
    when Hash
      obj.keys.sort.each_with_object({}) { |key, hsh| hsh[key] = sort_object(obj[key]) }
    when Array
      obj.map { |item| sort_object(item) }
    else
      obj
    end
  end
end

if __FILE__ == $0
  unless ENV['TEST'] == 'yes'
    str = ARGF.read
    obj = RecursiveSort.parse_string(str)
    puts RecursiveSort.sort_object(obj).to_yaml
  else
    require 'minitest/autorun'

    describe RecursiveSort do
      describe 'when parsing "on" key' do
        it 'treats as "on" instead of true' do
          str = <<~EOF
            on:
              schedule:
              - cron: '0 16,18,20,22 * * 1-5'
              workflow_dispatch:
                inputs:
                  image_tag:
                    description: 'The docker image tag to deploy'
                    required: true
                    type: string
            EOF
          obj = RecursiveSort.parse_string(str)
          expect(obj.keys.first).must_equal 'on'
        end
      end
    end
  end
end
