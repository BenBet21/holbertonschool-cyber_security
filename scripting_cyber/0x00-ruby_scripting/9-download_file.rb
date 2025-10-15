#!/usr/bin/env ruby
require 'open-uri'
require 'uri'
require 'fileutils'

def download_file(url, local_path)
  uri = URI.parse(url)
  dir = File.dirname(local_path)
  FileUtils.mkdir_p(dir) unless dir == '.' || dir == ''
  puts "Downloading file from #{url}..."
  URI.open(uri) do |remote|
    IO.copy_stream(remote, local_path)
  end
  puts "File downloaded and saved to #{local_path}."
end

if ARGV.length != 2
  puts "Usage: 9-download_file.rb URL LOCAL_FILE_PATH"
  exit
end

url, local_path = ARGV[0], ARGV[1]

begin
  download_file(url, local_path)
rescue OpenURI::HTTPError, SocketError, URI::InvalidURIError => e
  STDERR.puts "Failed to download file: #{e.message}"
  exit 1
end
