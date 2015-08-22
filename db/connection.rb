require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "./db/reminders.db"
)

ActiveRecord::Schema.define do
  unless ActiveRecord::Base.connection.tables.include? 'reminders'
    create_table :reminders do |table|
      table.column :text,     :string
      table.column :has_been_reminded,     :boolean
      table.column :at, :time
    end
  end
end
