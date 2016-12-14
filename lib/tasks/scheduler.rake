task :send_reminders => :environment do
	Mailgun.activation_reminder
end
