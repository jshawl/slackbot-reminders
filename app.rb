require_relative 'db/connection'
require_relative 'models/reminder'

Reminder.all.each do |reminder|
  reminder.remind if reminder.at_passed? && !reminder.has_been_reminded
end