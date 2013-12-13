# coding: utf-8
class ArticlesController < ApplicationController
  # layout :false
  def show
    @article = Article.find(params[:id])
  end

  def index
  	@articles = Article.all#.order(:created_at => :desc).limit(10)
  end
end
