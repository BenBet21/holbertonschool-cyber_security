#!/usr/bin/env ruby
require 'json'

def merge_json_files(file1_path, file2_path)
  # Lire les deux fichiers
  file1_data = JSON.parse(File.read(file1_path))
  file2_data = JSON.parse(File.read(file2_path))

  # Fusionner les tableaux
  merged_data = file2_data + file1_data

  # Écrire le résultat dans file2_path
  File.open(file2_path, 'w') do |f|
    f.write(JSON.pretty_generate(merged_data))
  end
end
