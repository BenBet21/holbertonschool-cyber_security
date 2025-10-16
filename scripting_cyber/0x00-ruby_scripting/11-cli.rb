#!/usr/bin/env ruby
require 'optparse'
require 'fileutils'

TASKS_FILE = 'tasks.txt'

# Crée le fichier s'il n'existe pas
FileUtils.touch(TASKS_FILE) unless File.exist?(TASKS_FILE)

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: cli.rb [options]"

  opts.on('-aTASK', '--add=TASK', 'Add a new task') do |task|
    options[:add] = task
  end

  opts.on('-l', '--list', 'List all tasks') do
    options[:list] = true
  end

  opts.on('-rINDEX', '--remove=INDEX', Integer, 'Remove a task by index') do |index|
    options[:remove] = index
  end

  opts.on('-h', '--help', 'Show help') do
    puts opts
    exit
  end
end.parse!

# Action : Ajouter une tâche
if options[:add]
  File.open(TASKS_FILE, 'a') { |f| f.puts options[:add] }
  puts "Task '#{options[:add]}' added."
end

# Action : Lister les tâches
if options[:list]
  tasks = File.readlines(TASKS_FILE, chomp: true)
  if tasks.empty?
    puts "No tasks found."
  else
    tasks.each_with_index do |task, index|
      puts "#{index + 1}. #{task}"
    end
  end
end

# Action : Supprimer une tâche
if options[:remove]
  tasks = File.readlines(TASKS_FILE, chomp: true)
  index = options[:remove] - 1
  if index < 0 || index >= tasks.length
    puts "Invalid task index."
  else
    removed = tasks.delete_at(index)
    File.write(TASKS_FILE, tasks.join("\n") + "\n")
    puts "Task '#{removed}' removed."
  end
end
