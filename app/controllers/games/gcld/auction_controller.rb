# 竞拍
class Games::Gcld::AuctionController < ApplicationController
  layout 'auction'
  def auction_princes_index
    # role_type_id = Games::Gcld::RoleType.where(:db_id => 2100).first.id
    @castellans = Games::Gcld::Castellan.where(:role_type_id => 2100).desc(:created_at)
    render :layout => false if params[:pjax]
  end

  def auction_prince
    castellan = Games::Gcld::Castellan.find(params[:castellan_id])
    current_castellan = castellan.user_castellan
    user_castellan = Games::Gcld::UserCastellan.create(:user => current_user, :castellan => castellan, :price => params[:price])
    castellan.inc(:price => 100)
    if current_castellan.nil?
      castellan.set(:user_castellan_id => user_castellan.id)
      castellan.set(:user => current_user.id)
    else
      if user_castellan.price > castellan.user_castellan.price
        castellan.set(:user_castellan_id => user_castellan.id)
      castellan.set(:user => current_user.id)
      end
    end    
    castellan.save!
    castellan.reload

    render :json => {:user_name => castellan.user_castellan.user.name}
  end
end
