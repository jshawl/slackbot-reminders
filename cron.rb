require_relative 'db/connection'
require_relative 'models/reminder'
require_relative 'models/slackbot'


Reminder.all.each do |reminder|
  reminder.remind if reminder.at_passed? && !reminder.has_been_reminded
end