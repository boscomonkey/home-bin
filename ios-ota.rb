#!/usr/bin/env ruby

require 'uri'

def usage
  puts <<EOF
USAGE:  #{$0} TITLE PROVISION_URL PLIST_FNAME"

TITLE         - i.e., "Angry Bird rev 0.0.4"
PROVISION_URL - full URL of the the provisioning profile:  i.e.,
                "http://example.com/dl/4565-B2B7-A2FEC8A50757.mobileprovision"
PLIST_FNAME   - filename (including extension) of the plist file:  i.e.,
                "angrybird.plist"
EOF
  exit 1
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
<!DOCTYPE html>
<html>
  <head>
    <title>#{title}</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-type" content="text/html; charset=utf-8">
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.0rc2/jquery.mobile-1.0rc2.min.css" />
    <script src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
    <script src="http://code.jquery.com/mobile/1.0rc2/jquery.mobile-1.0rc2.min.js"></script>
    <style>
		.qrcode {
			display: block;
			margin: 0 auto;
			padding: 4px;
		}
    </style>
  </head>

  <body>
    <div data-theme="b"
         data-role="page" id="splash" data-title="#{title}">
      <div data-role="header">
        <h1>#{title}</h1>
      </div>

      <div data-role="content">
        <h3>#{title}</h3>

        <p>
          In order to install this app on your IOS 4.0 (or later)
          device, click the two buttons below in the order in which
          they appear.
        </p>

        <p>
          The first button will take you away from your web
          browser. Remember to return to your browser afterward to
          finish the installation.
        </p>

        <div data-role="fieldcontain">
        <a href="#{provision_url}"
           rel="external"
           data-role="button" data-icon="arrow-r"
           data-iconpos="right">Install Provisioning File</a>
        <a href="itms-services://?action=download-manifest&url=#{plist_url}"
              data-role="button" data-icon="arrow-r"
              data-iconpos="right">Install Application</a>
          		</div>

        <div data-role="fieldcontain">
      		<p>Scan this QR code with your iPhone (e.g., NeoReader, RedLaser, etc) to load this page:</p>

  				<script>
  				document.write("<img class='qrcode' src='http://chart.apis.google.com/chart?cht=qr&chs=150x150&chld=H|0&chl="
  								+ document.location.href
  								+ "' />");
  				</script>
  			</div>
      </div>

      <!--
      <div data-role="footer">
        <h4>#{Time.now}</h4>
      </div>
      -->
    </div>

  </body>
</html>
EOF
