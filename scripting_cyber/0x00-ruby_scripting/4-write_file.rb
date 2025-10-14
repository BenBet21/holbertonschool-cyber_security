#!/usr/bin/env ruby
require 'json'

def merge_json_files(source_path, target_path)
  # Charger et convertir le contenu du fichier source en tableau Ruby
  source_json_text = File.read(source_path)
  source_entries = JSON.parse(source_json_text)

  # Charger et convertir le contenu du fichier cible en tableau Ruby
  target_json_text = File.read(target_path)
  target_entries = JSON.parse(target_json_text)

  # Ajouter les entrées du fichier source à celles du fichier cible
  combined_entries = target_entries + source_entries

  # Réécrire le fichier cible avec les données fusionnées
  File.write(target_path, JSON.pretty_generate(combined_entries))

  # Message de confirmation (optionnel)
  puts 'Les données JSON ont été fusionnées avec succès.'
end
