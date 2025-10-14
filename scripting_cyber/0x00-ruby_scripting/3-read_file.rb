#!/usr/bin/env ruby
require 'json'  # Charge la bibliothèque JSON pour lire et interpréter le fichier

def count_user_ids(path)
  file_content = File.read(path)  # Lit le contenu brut du fichier JSON
  data = JSON.parse(file_content)  # Transforme le texte JSON en tableau Ruby d'objets (hashes)

  user_counts = Hash.new(0)  # Crée un dictionnaire avec valeur par défaut 0

  data.each do |entry|  # Parcourt chaque objet du tableau
    user_id = entry["userId"]  # Récupère la valeur de la clé "userId"
    user_counts[user_id] += 1  # Incrémente le compteur pour ce userId
  end

  user_counts.sort.each do |user_id, count|  # Trie les userId par ordre croissant
    puts "#{user_id}: #{count}"  # Affiche le résultat
  end
end
