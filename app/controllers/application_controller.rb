class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  before_action :skip_session

  private

  def skip_session
    request.session_options[:skip] = true
  end
end
