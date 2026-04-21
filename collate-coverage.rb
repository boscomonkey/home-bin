#!/usr/bin/env ruby

# Merge SimpleCov .resultset.json fragments produced by parallel test
# shards into a single coverage report. Point it at a directory that
# contains one or more .resultset.json files.
#
# Usage: collate-coverage.rb DIR

require 'simplecov'
require 'json'

dir_spec = ARGV[0]
raise 'ERROR: directories where .resultset.json must be specified' if (dir_spec.nil? || dir_spec == '')

SimpleCov.collate Dir["#{dir_spec}/.resultset.json"]
