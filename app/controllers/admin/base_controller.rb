# coding: utf-8
class Admin::BaseController < ApplicationController
  layout "admin"
  before_filter do
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == 'admin' && password == 'admin'
    end
  end
end
