# coding: utf-8
class Message::SysMessagesController < ApplicationController
  def index
  	# @messages = Message::SysMessage.where(:receiver => current_user)#.find(params[:id]).messages.paginate(:page => params[:page], :per_page => 10)
  	@messages = Message::SysMessage.where(:receiver => current_user).paginate(:page => params[:page], :per_page => 10)
  end
end
