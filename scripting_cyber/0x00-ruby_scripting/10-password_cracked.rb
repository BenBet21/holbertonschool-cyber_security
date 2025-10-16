#!/usr/bin/env ruby
require 'digest'

# Vérification des arguments
if ARGV.length != 2
  puts "Usage: 10-password_cracked.rb HASHED_PASSWORD DICTIONARY_FILE"
  exit
end

hashed_password = ARGV[0]
dictionary_file = ARGV[1]

# Lecture du dictionnaire
begin
  File.foreach(dictionary_file) do |line|
    word = line.strip
    hash = Digest::SHA256.hexdigest(word)
    if hash == hashed_password
      puts "Password found: #{word}"
      exit
    end
  end
rescue Errno::ENOENT
  STDERR.puts "Dictionary file not found: #{dictionary_file}"
  exit 1
end

# Si aucun mot ne correspond
puts "Password not found in dictionary."
