require 'chronic'
require 'active_record'
require_relative './slackbot'

class Reminder < ActiveRecord::Base
  def self.initialize_from_english channel, text
    @text = text.split(";")[0]
    @channel = channel
    @at = Chronic.parse(text.split(";")[1])
    self.new(text: @text, at: @at, channel: @channel)
  end

  def self.create_from_english channel, text
    s = self.initialize_from_english(channel, text)
    s.save
    p s
  end

  def at_passed?
    Time.now > self.at
  end

  def remind
    s = Slackbot.new
    s.reply(self.channel, "Reminder! " + self.text)
    self.has_been_reminded = true
    self.save
  end
end
