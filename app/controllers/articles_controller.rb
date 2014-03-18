# coding: utf-8
class ArticlesController < ApplicationController
  # layout :false
  def show
    @article = Article.find(params[:id])
  end

  def index
  	@articles = Article.all.sort(:created_at => :desc)#.paginate(:page => params[:page], :per_page => 30)
  end
end
