# Reminders Slackbot

![](https://dl.dropboxusercontent.com/s/xv8m8n0yisaqq4z/reminder-clipart-4TbodG4Tg.gif?dl=0)

## Usage

Configure a new bot integration at `https://<your-team-name>.slack.com/services/new/bot`

Send a direct message to the bot:

>Walk the dog; at 5pm

Everything before the ";" is the reminder. Everything after the semi-colon is when the reminder will be sent back.
The complete list of available time descriptions can be found here - https://github.com/mojombo/chronic#examples

## Local Setup

### Configure Environment Variables

Create a file named `env.rb` in the project root:

```rb
# env.rb

ENV['access_token'] = "Token you got from https://<your-team-name>.slack.com/services/new/bot"
```

Configure an absolute path to the db:

```rb
# db/connection.rb

require 'active_record'

ActiveRecord::Base.default_timezone = :local
ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "/absolute/path/to/db/reminders.db"
)
```

## Start the Web Socket Server

    ruby listen.rb

Keep this script running in the background with `tmux` or `god`

This listens for new direct messages to create the reminders.

## Configure the Cron Job

```
*/5 * * * * ruby /path/to/reminders/cron.rb
```

This checks the time specified in the reminder and sends the reminder
if the time has passed and the reminder has not yet been sent.

Note: environment variables are limited in a cron environment. If using RVM, follow 
https://rvm.io/deployment/cron to configure cron environment.
