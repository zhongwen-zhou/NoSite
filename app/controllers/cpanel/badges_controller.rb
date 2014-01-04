class Cpanel::BadgesController < Cpanel::ApplicationController

  def index
    @badges = Badge.desc(:_id).paginate :badge => params[:badge], :per_badge => 30

  end

  def show
    @badge = Badge.find(params[:id])

  end

  def new
    @badge = Badge.new

  end

  def edit
    @badge = Badge.find(params[:id])
  end

  def create
    @badge = Badge.new(params[:badge].permit!)

    if @badge.save
      redirect_to(cpanel_badges_path, :notice => 'Badge was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @badge = Badge.unscoped.find(params[:id])
    @badge.title = params[:badge][:title]
    @badge.body = params[:badge][:body]
    @badge.slug = params[:badge][:slug]
    @badge.locked = params[:badge][:locked]
    @badge.user_id = current_user.id

    if @badge.save
      redirect_to(cpanel_badges_path, :notice => 'Badge was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @badge = Badge.unscoped.find(params[:id])
    @badge.destroy

    redirect_to(cpanel_badges_path)
  end
end
