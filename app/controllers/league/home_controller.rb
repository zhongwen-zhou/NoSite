# coding: utf-8
class League::HomeController < ApplicationController
  def index
    @league = current_user.try(:league) || League::League.new
  end
end
