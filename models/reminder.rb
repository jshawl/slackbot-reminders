require 'chronic'
require 'active_record'
require_relative './slackbot'

class Reminder < ActiveRecord::Base
  def self.initialize_from_english channel, text
    unless text.match(/;/)
      Slackbot.new.reply(channel, "Usage: 'thing to do; when to do it'")
      return
    end
    @text = text.split(";")[0]
    @channel = channel
    @at = Chronic.parse(text.split(";")[1])
    self.new(text: @text, at: @at, channel: @channel)
  end

  def self.create_from_english channel, text
    s = self.initialize_from_english(channel, text)
    if s
      s.save
      Slackbot.new.reply(channel, "Reminder created successfully!")
    end
  end

  def at_passed?
    Time.now > self.at
  end

  def remind
    Slackbot.new.reply(self.channel, "Reminder! " + self.text)
    self.has_been_reminded = true
    self.save
  end
end
