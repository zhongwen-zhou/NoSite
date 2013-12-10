# coding: utf-8
class HomeController < ApplicationController
  def index
    # @excellent_topics = ::Bbs::Topic.excellent.recent.fields_for_list.includes(:user).limit(20)
    # drop_breadcrumb("首页", root_path)
    @share_content = {:web_spread => true}
  end
end
