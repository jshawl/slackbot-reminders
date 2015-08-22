require_relative 'db/connection'
require_relative 'models/reminder'
require_relative 'models/slackbot'

Slackbot.new.connect
