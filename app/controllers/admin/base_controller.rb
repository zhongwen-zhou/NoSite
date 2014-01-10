class Admin::BaseController < ActionController::Base
	protect_from_forgery
  layout "admin"
  before_filter do
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == 'admin' && password == 'admin'
    end
  end
end
