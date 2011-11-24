module AuthentificationsHelper
  def log_in
    cookies.permanent.signed[:remember_token] = [Time.now]
  end

  def log_out
    cookies.delete(:remember_token)
  end

  def loged_in?
    !cookies.signed[:remember_token].nil?
  end
end
