# coding: utf-8
class Message::HomeController < ApplicationController
  def index
  	@communications = Message::Communication.user_communication(current_user)
  end
end
