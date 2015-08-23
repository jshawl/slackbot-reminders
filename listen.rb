require_relative 'db/connection'
require_relative 'models/reminder'
require_relative 'models/slackbot'
require_relative './env'

Slackbot.new.connect
