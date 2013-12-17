# coding: utf-8
class League::HomeController < ApplicationController
  def index
    @league = current_user.league || League::League.new
  end
end
