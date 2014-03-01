# coding: utf-8
class League::MembersController < ApplicationController

  before_filter :except => [:create] do
    @league = League::League.find(params[:league_id])
    @member = League::Member.find(params[:member_id])
  end

  def set_vice_president
    @member.set(:role => 1)
  end

  def cancel_vice_president
    @member.set(:role => 0)
  end

  def set_conductor
    @member.set(:role => 2)
  end

  def cancel_conductor
    @member.set(:role => 0)
  end

  def set_spokesman
    @member.set(:role => 3)
  end

  def cancel_spokesman
    @member.set(:role => 0)
  end  
end