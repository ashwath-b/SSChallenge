# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"

# Learn more: http://github.com/javan/whenever
every 1.day, :at => '11.59 pm' do
  runner "Mailgun.activation_reminder"
end
