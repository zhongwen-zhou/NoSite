# coding: utf-8
class Cpanel::Bbs::RepliesController < Cpanel::ApplicationController

  def index
    @replies = ::Bbs::Reply.unscoped.desc(:_id).paginate :page => params[:page], :per_page => 30
  end

  def show
    @reply = ::Bbs::Reply.unscoped.find(params[:id])

    if @reply.topic.blank?
      redirect_to cpanel_replies_path, :alert => "帖子已经不存在"
    end
  end

  def new
    @reply = ::Bbs::Reply.new
  end

  def edit
    @reply = ::Bbs::Reply.unscoped.find(params[:id])
  end


  def create
    @reply = ::Bbs::Reply.new(params[:reply].permit!)

    if @reply.save
      redirect_to(cpanel_replies_path, :notice => '::Bbs::Reply was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @reply = ::Bbs::Reply.unscoped.find(params[:id])

    if @reply.update_attributes(params[:reply].permit!)
       redirect_to(cpanel_replies_path, :notice => '::Bbs::Reply was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @reply = ::Bbs::Reply.unscoped.find(params[:id])
    @reply.destroy
  end
end
