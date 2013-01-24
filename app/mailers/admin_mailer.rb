class AdminMailer < ActionMailer::Base
  default from: "uboarders@gmail.com"

  def welcome_email(admin)
    @admin = admin
    @url = url_for(:controller => :admin, :action => sign_in)
    mail(:to => admin.email, :subject => "Welcome to the Uboard")
  end
end
