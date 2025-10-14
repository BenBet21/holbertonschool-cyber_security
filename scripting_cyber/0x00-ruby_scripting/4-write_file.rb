#!/usr/bin/env ruby

require 'json'

def merge_json_files(file1_path, file2_path)
  # Lit et convertit le 1er fichier JSON
  file1_content = File.read(file1_path)
  data1 = JSON.parse(file1_content)

  # Lit et convertit le 2nd fichier JSON
  file2_content = File.read(file2_path)
  data2 = JSON.parse(file2_content)

  # Compile les deux objets JSON (ajoute Data1 à Data2)
  merged_data = data2 + data1

  # Ecrit la compilation effectuée dans file2
  File.write(file2_path, JSON.pretty_generate(merged_data))

  puts 'Merged JSON written to file.json'
  
end
