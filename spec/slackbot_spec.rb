require_relative "../models/slackbot"

s = Slackbot.new

describe "Slackbot" do
  describe "::initialize" do
    it "should have an access_token" do
      expect(s.access_token).not_to be(nil)
    end
    it "should have a websocket server url" do
      expect(s.wss).not_to be(nil)
    end
    it "should connect to the websocket server" do
      expect(s.connection).not_to be(nil)
    end
  end
  describe "#reply" do
    it "should get a response" do
      response = s.reply("D09F9AZ0U", "testing-from-rspec")
      expect(response["ok"])
    end
  end
end