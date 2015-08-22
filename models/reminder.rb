require 'chronic'
require 'active_record'

class Reminder < ActiveRecord::Base
  def self.initialize_from_english text
    @text = text.split(";")[0]
    @at = Chronic.parse(text.split(";")[1])
    self.new(text: @text, at: @at)
  end

  def self.create_from_english text
    s = self.initialize_from_english text
    s.save
  end

  def at_passed?
    Time.now > self.at
  end

  def remind
    puts "Reminder! #{self.text}"
    self.has_been_reminded = true
    self.save
  end

end
