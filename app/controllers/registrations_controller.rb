class RegistrationsController < Devise::RegistrationsController

  prepend_before_filter :require_no_authentication, :only => [ :cancel ]
  def new
    if Admin.exists? && !admin_signed_in?
      flash[:notice] = "Sign in first to sign up the new admin"
      redirect_to "/admins/sign_in"
    else
      super
    end
  end
end
