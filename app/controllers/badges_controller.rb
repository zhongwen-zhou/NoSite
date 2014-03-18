class BadgesController < ApplicationController
  before_filter do
    @badge_winer = BadgeWinner.find(params[:id])
  end
  def garb
    @badge_winer.set(:status => 1)
    render :text => false
  end

  def off
    @badge_winer.set(:status => 0)
    render :text => true
  end
end
