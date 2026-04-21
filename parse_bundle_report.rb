#!/usr/bin/env ruby -n -r semver

# Parse colorized `bundle outdated` output and emit a TSV row per gem
# with installed version, latest version, and a semver bump class
# (patch / minor / major / unparsable / unknown).
#
# Usage: bundle outdated | parse_bundle_report.rb

# strip out escape code first, then try to match regexp
#	https://stackoverflow.com/a/35894736
#
# puts "#{$1}\t#{$2}\t#{$3}\t#{$4}\t#{$5}" \
#   if $_.gsub(/\e\[([;\d]+)?m/, '') =~ /(.+) (.+): released (.+) \(latest version, (.+), released (.+)\)/i

decolorized = $_.gsub(/\e\[([;\d]+)?m/, '')

if decolorized =~ /(.+) (.+): released (.+) \(latest version, (.+), released (.+)\)/i
  name = $1
  installed = $2
  latest = $4

  v0 = SemVer.parse installed
  v1 = SemVer.parse latest

  status = if v0.nil? || v1.nil?
             :unparsable
           elsif v0.major == v1.major && v0.minor == v1.minor && v0.patch < v1.patch
             :patch
           elsif v0.major == v1.major && v0.minor < v1.minor
             :minor
           elsif v0.major < v1.major
             :major
           else
             :unknown
           end

  puts "#{name}\t#{installed}\t#{$3}\t#{latest}\t#{$5}\t#{status}"
end
