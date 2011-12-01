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

  def authenticate
    deny_access unless signed_in?
  end

  def deny_access
    redirect_to login_path, :notice => t(:please_sign_in)
  end

  def current_feature_description=(feature_description)
    @current_feature_description = feature_description
  end

  def current_feature_description
    @current_feature_description ||= feature_description_from_session
  end

  def set_current_feature_description(id)
    session[:id] = id
    self.current_feature_description = FeatureDescription.find_by_id(id)
  end

  private
    def feature_description_from_session
      FeatureDescription.find_by_id(session[:id])
    end
end
