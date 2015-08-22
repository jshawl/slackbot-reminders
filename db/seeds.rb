require 'pry'
require_relative 'connection'
require_relative '../models/reminder'

Reminder.destroy_all
Reminder.create_from_english("walk dogs; yesterday at 3")
Reminder.create_from_english("eat pizza; tomorrow at 3")

binding.pry

puts "pry bug makes me want to use byebug"
