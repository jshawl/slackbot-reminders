require_relative 'db/connection'
require_relative 'models/reminder'

if r.at_passed?
  puts "r at passed"
  unless r.has_been_reminded
    puts "r has not been reminded"
    r.remind
  end
end