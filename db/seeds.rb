require 'pry'
require_relative 'connection'
require_relative '../models/reminder'

Reminder.destroy_all
Reminder.create_from_english("D09F9AZ0U","walk dogs; today at 4pm")
Reminder.create_from_english("D09F9AZ0U","eat pizza; tomorrow at 3")

binding.pry

puts "pry bug makes me want to use byebug"
