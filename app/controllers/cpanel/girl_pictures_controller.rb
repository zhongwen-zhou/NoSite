class Cpanel::GirlPicturesController < Cpanel::ApplicationController

  def index
    @pictures = ::GirlPicture.all
  end

  def show
    @badge = Badge.find(params[:id])

  end

  def new
    @picture = ::GirlPicture.new

  end

  def edit
    @picture = ::GirlPicture.find(params[:id])
  end

  def create
    @picture = ::GirlPicture.new(params[:girl_picture].permit!)

    if @picture.save
      redirect_to(cpanel_girl_pictures_path, :notice => 'Badge was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @picture = ::GirlPicture.find(params[:id])

    @picture.update_attributes(params[:girl_picture].permit!)

    if @picture.save
      redirect_to(cpanel_girl_pictures_path, :notice => 'Badge was successfully updated.')
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
