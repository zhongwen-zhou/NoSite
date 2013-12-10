# coding: utf-8
class ArticlesController < ApplicationController
  # layout :false
  def show
    @article = Article.find(params[:id])
  end
end
