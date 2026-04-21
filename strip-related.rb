#!/usr/bin/env ruby

# Strip everything from the first 'Related Articles' heading to end of
# input. Useful for cleaning scraped article text before post-processing.
#
# Usage: strip-related.rb < article.txt

puts ARGF.read.gsub(/Related Articles.*/m, '')
