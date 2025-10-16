#!/usr/bin/env ruby
require 'optparse'  # Permet de gérer les options en ligne de commande

# Fichier où les tâches seront stockées
TASKS_FILE = 'tasks.txt'

# Charge les tâches depuis le fichier ou retourne un tableau vide si le fichier n'existe pas
def load_tasks
  if File.exist?(TASKS_FILE)
    File.readlines(TASKS_FILE).map(&:chomp)  # Supprime les retours à la ligne
  else
    []
  end
end

# Sauvegarde les tâches dans le fichier
def save_tasks(tasks)
  File.open(TASKS_FILE, 'w') do |file|
    tasks.each { |task| file.puts(task) }  # Écrit chaque tâche sur une ligne
  end
end

# Ajoute une nouvelle tâche
def add_task(task)
  tasks = load_tasks
  tasks << task  # Ajoute la tâche à la fin du tableau
  save_tasks(tasks)
  puts "Task '#{task}' added."
end

# Liste toutes les tâches
def list_tasks
  tasks = load_tasks
  if tasks.empty?
    puts "No tasks found."  # Message si aucune tâche
  else
    puts "Tasks:"
    tasks.each_with_index do |task, index|
      puts "#{index + 1}. #{task}"  #
