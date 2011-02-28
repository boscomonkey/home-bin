#!/usr/bin/env ruby

require 'uri'

def usage
  puts "USAGE: #{$0} TITLE PROVISION_URL PLIST_FNAME"
  exit
end

def get_base_dir url
  uri = URI.parse url
  dir = File.dirname uri.request_uri
  uri.path = dir
  uri.to_s
end

title = ARGV[0] or usage
provision_url = ARGV[1] or usage
plist_fname = ARGV[2] or usage

base_url = get_base_dir provision_url
plist_url = "#{base_url}/#{plist_fname}"
readme_url = "#{base_url}/readme.html"

print <<EOF
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML//EN">
<html>
  <head>
    <title>#{title}</title>
    <style>
      body {
      font-family: Verdana, Helvetica, sans-serif;
      font-size: smaller;
      }
    </style>
  </head>

  <body>
    <h1>#{title}</h1>

   <p>
      In order to install this app on your IOS 4.2 device, click the
      two links below in your IOS Safari browser:
    </p>

    <ol>
      <li>
	<a href="#{provision_url}">
	Install Provisioning File</a>
      </li>
      <li>
	<a href="itms-services://?action=download-manifest&url=#{plist_url}">
	Install Application</a>
      </li>
    </ol>

    <hr>
    <address>
      <p>
	The URL for this page
	is <a href="#{readme_url}">#{readme_url}</a>
      </p>
    </address>
    <!-- hhmts start --> Last modified: #{Time.now} <!-- hhmts end -->
  </body>
</html>
EOF
