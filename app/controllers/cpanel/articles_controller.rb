class Cpanel::ArticlesController < Cpanel::ApplicationController

  def index
    @articles = Article.unscoped.desc(:_id).paginate :article => params[:article], :per_article => 30

  end

  def show
    @article = Article.unscoped.find(params[:id])

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
    @article = Article.find(params[:id])
    @article.update_attributes!(params[:article].permit!)

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
