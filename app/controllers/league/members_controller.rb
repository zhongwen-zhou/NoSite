# coding: utf-8
class League::MembersController < ApplicationController
  # layout :false

        # get :set_vice_president
        # get :canel_vice_president
        # get :set_conductor
        # get :canel_conductor

  before_filter :except => [:create] do
    @league = League::League.find(params[:league_id])
    @member = League::Member.find(params[:member_id])
  end

  def set_vice_president
    @member.set(:role => 1)
  end

  def canel_vice_president
    @member.set(:role => 0)
  end

  def set_conductor
    @member.set(:role => 2)
  end

  def canel_conductor
    @member.set(:role => 0)
  end
end