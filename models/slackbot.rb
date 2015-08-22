require 'httparty'
require 'eventmachine'
require 'faye'
require 'pry'
require 'uri'
require_relative './reminder'

class Slackbot
  attr_accessor :access_token
  def initialize
    @access_token = ENV['access_token']
  end
  def wss
    JSON.parse(HTTParty.get("https://slack.com/api/rtm.start?token=#{@access_token}").body)["url"]
  end
  def connect
    EM.run {
      ws = Faye::WebSocket::Client.new(self.wss)
      ws.on :message do |event|
	data = JSON.parse(event.data)
	if data["type"] == "message"
          self.message_received data
	end
      end
    }
  end
  def message_received message
    unless message["user"] == self.user_id
      Reminder.create_from_english(message["channel"], message["text"])
    end
  end
  def reply channel, text
    query = "?token=#{self.access_token}&as_user=true&channel=#{channel}&text=#{URI.escape(text)}"
    JSON.parse(HTTParty.get("https://slack.com/api/chat.postMessage#{query}").body)
  end
  def user_id
   JSON.parse(HTTParty.get("https://slack.com/api/auth.test?token=#{self.access_token}").body)["user_id"]
  end
end