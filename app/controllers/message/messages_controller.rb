# coding: utf-8
class Message::MessagesController < ApplicationController
  def index
  	@message = Message::Message.new
  	@messages = Message::Communication.find(params[:id]).messages.paginate(:page => params[:page], :per_page => 10)
  end

  def create
  	@communication = Message::Communication.find(params[:id])
  	@message = @communication.messages.create(:sender => current_user,
  											 :receiver => @communication.another_person(current_user),
  											 :content => params[:message_message][:content])
  	# redirect_to message_messages_path(@communication)
  end
end
