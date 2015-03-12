# coding: utf-8
class Message::HomeController < ApplicationController
  def index
  	@communications = Message::Communication.user_communication(current_user).paginate(:page => params[:page], :per_page => 10)
  end
end
