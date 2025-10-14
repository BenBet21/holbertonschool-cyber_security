#!/usr/bin/env ruby
require 'json'

def merge_json_files(file1_path, file2_path)
  file1_content = File.read(file1_path)
  file2_content = File.read(file2_path)

  file1_data = JSON.parse(file1_content)
  file2_data = JSON.parse(file2_content)

  merged_data = file2_data + file1_data

  File.open(file2_path, 'w') do |file|
    file.write(JSON.generate(merged_data))
  end
end
