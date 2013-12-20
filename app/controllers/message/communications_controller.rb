# coding: utf-8
class Message::CommunicationsController < ApplicationController
  def start
    communication = Message::Communication.where(:sender => current_user, :receiver_id => params[:user_id]).first
    communication ||= Message::Communication.where(:sender_id => params[:user_id], :receiver => current_user).first
    communication ||= Message::Communication.create(:sender => current_user, :receiver_id => params[:user_id])
    @message = Message::Message.new
    redirect_to message_messages_path(communication)
  end
end
