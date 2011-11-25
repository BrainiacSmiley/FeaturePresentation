module AuthentificationsHelper
  def sign_in
    session[:sign_in] = Time.now
  end

  def sign_out
    session[:sign_in] = nil
  end

  def signed_in?
    !session[:sign_in].nil?
  end
end
