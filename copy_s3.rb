#!/usr/bin/env ruby

require 'rubygems'
require 'right_aws'
require 'pp'

class CopyS3
  def initialize key, secret
    @s3 = RightAws::S3Interface.new key, secret
  end

  def copy src_bucket, dest_bucket, obj_name
    dest_obj = "test/#{obj_name}"

    @s3.copy src_bucket, obj_name, dest_bucket, dest_obj, :copy, {}
    src_acl = @s3.get_acl src_bucket, obj_name
    @s3.put_acl dest_bucket, dest_obj, src_acl[:object]
  end
end

if __FILE__ == $0
  key       = ARGV[0]
  secret    = ARGV[1]
  src       = ARGV[2]
  dest      = ARGV[3]
  file_list = ARGV[4]

  if key.nil? || secret.nil? || src.nil? || dest.nil? || file_list.nil?
    puts key, secret, src, dest, file_list

    STDERR.puts <<EOF
USAGE: #{File.basename $0} KEY SECRET SRC_BUCKET DEST_BUCKET FILE_LIST
EOF
    exit 1
  end

  copier = CopyS3.new key, secret
  b = Benchmark.measure do
    open(file_list) do |fin|
      fin.read.each_line do |l|
        puts ">>> #{l}"
        copier.copy src, dest, l.strip
      end
    end
  end

  pp b
end
