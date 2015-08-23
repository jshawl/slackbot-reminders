require 'active_record'

ActiveRecord::Base.default_timezone = :local
ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "/home/jesse/slackbot-reminders/db/reminders.db"
)

ActiveRecord::Schema.define do
  unless ActiveRecord::Base.connection.tables.include? 'reminders'
    create_table :reminders do |table|
      table.column :text,     :string
      table.column :at, :timestamp
      table.column :has_been_reminded,     :boolean
      table.column :channel,     :string
    end
  end
end
