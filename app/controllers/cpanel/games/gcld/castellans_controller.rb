class Cpanel::Games::Gcld::CastellansController < Cpanel::ApplicationController

  def index
    # @articles = Article.unscoped.desc(:_id).paginate :article => params[:article], :per_article => 30
  end

  def start_auction_zhaizhu
    ::Games::Gcld::Castellan.zhaizhu_auction_times.reset params[:auction_time].to_i.minutes
    ::Games::Gcld::Castellan.start_auction_at.reset Time.now.to_i
    redirect_to cpanel_games_gcld_castellans_path
  end

  def start_auction_generals
    ::Games::Gcld::Castellan.generals_auction_times.reset params[:auction_time].to_i.minutes
    ::Games::Gcld::Castellan.start_auction_generals_at.reset Time.now.to_i
    redirect_to cpanel_games_gcld_castellans_path
  end

  def new
    @article = Article.new

  end

  def edit
    @article = Article.unscoped.find(params[:id])
  end

  def create
    @article = Article.new(params[:article].permit!)

    if @article.save
      redirect_to(cpanel_articles_path, :notice => 'Article was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @article = Article.unscoped.find(params[:id])
    @article.title = params[:article][:title]
    @article.body = params[:article][:body]
    @article.slug = params[:article][:slug]
    @article.locked = params[:article][:locked]
    @article.user_id = current_user.id

    if @article.save
      redirect_to(cpanel_articles_path, :notice => 'Article was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @article = Article.unscoped.find(params[:id])
    @article.destroy

    redirect_to(cpanel_articles_path)
  end
end
