#!/usr/bin/env ruby

# Convert a list of Kafka topic names (one per line, on stdin) into
# Ruby constant declarations. Each topic "user_signup" becomes:
#     USER_SIGNUP = 'user_signup'.freeze
#
# Usage: generate-kafka-topics.rb < topics.txt

ARGF.each_line do |line|
  topic = line.strip

  konst = topic.snake_case.upcase
  puts "    #{konst} = '#{topic}'.freeze"
end

