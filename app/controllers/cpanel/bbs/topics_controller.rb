# coding: utf-8
class Cpanel::Bbs::TopicsController < Cpanel::ApplicationController

  def index
    @topics = ::Bbs::Topic.unscoped.desc(:_id).includes(:user).paginate :page => params[:page], :per_page => 30

  end

  def show
    @topic = ::Bbs::Topic.unscoped.find(params[:id])

  end


  def new
    @topic = ::Bbs::Topic.new
  end

  def edit
    @topic = ::Bbs::Topic.unscoped.find(params[:id])
  end

  def create
    @topic = ::Bbs::Topic.new(params[:topic].permit!)

    if @topic.save
      redirect_to(cpanel_topics_path, :notice => '::Bbs::Topic was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @topic = ::Bbs::Topic.unscoped.find(params[:id])

    if @topic.update_attributes(params[:topic].permit!)
      redirect_to(cpanel_topics_path, :notice => '::Bbs::Topic was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @topic = ::Bbs::Topic.unscoped.find(params[:id])
    @topic.destroy_by(current_user)

    redirect_to(cpanel_topics_path)
  end

  def undestroy
    @topic = ::Bbs::Topic.unscoped.find(params[:id])
    @topic.update_attribute(:deleted_at, nil)
    redirect_to(cpanel_topics_path)
  end

  def suggest
    @topic = ::Bbs::Topic.unscoped.find(params[:id])
    @topic.update_attribute(:suggested_at, Time.now)
    CacheVersion.topic_last_suggested_at = Time.now
    redirect_to(cpanel_topics_path, :notice => "::Bbs::Topic:#{params[:id]} suggested.")
  end

  def unsuggest
    @topic = ::Bbs::Topic.unscoped.find(params[:id])
    @topic.update_attribute(:suggested_at, nil)
    CacheVersion.topic_last_suggested_at = Time.now
    redirect_to(cpanel_topics_path, :notice => "::Bbs::Topic:#{params[:id]} unsuggested.")
  end
end
