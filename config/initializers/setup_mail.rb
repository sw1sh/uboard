ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,
  :address => 'smtp.gmail.com',
  :port => 587,
  :domain => 'gmail.com',
  :authentication => :plain,
  :user_name => 'uboarders@gmail.com',
  :password => 'rfhfrfnbwf'
}
