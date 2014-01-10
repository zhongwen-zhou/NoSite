class HomeController < ApplicationController
	before_filter do
		@current_user = User.find(session[:current_user_id]) if session[:current_user_id]
	end
  def index
  end
end
