# 竞拍
class Games::Gcld::AuctionController < ApplicationController
  layout 'auction'
  def auction_princes_index

    @page = params[:page] || 1

    @page = @page.to_i
    @castellans = Games::Gcld::Castellan.where(:role_type_id => 2100).desc(:created_at).paginate :page => params[:page], :per_page => 14

    bought_castellan = Games::Gcld::Castellan.where(:role_type_id => 2100, :user_id => current_user.id).first

    gon.user_money = current_user.coins
    gon.castellans_info = {}

    @left_times = (Games::Gcld::Castellan.zhaizhu_auction_times.value.to_i-(Time.now.to_i - Games::Gcld::Castellan.start_auction_at.value))
    return render :text => '竞拍还没有开始，请等待！' if @left_times < 0

    # @left_times = "#{@left_times/60}:#{@left_times%60}"
    yushu = @left_times%60
    yushu = '0'+yushu.to_s if yushu.to_s.length == 1
    @left_times = "#{@left_times/60}:#{yushu}"



    respond_to do |format|
      format.html do
        @castellans.each do |castellan|
          gon.castellans_info[castellan.id] = {:id => castellan.id, 
                                    :db_id => castellan.db_id, 
                                    :name => castellan.name,
                                    :tong_shuai => castellan.tong_shuai, 
                                    :wu_li => castellan.wu_li,
                                    :zhi_li => castellan.zhi_li,
                                    :zheng_zhi => castellan.zheng_zhi}
        end
        render :layout => false if params[:pjax]
      end
      format.json do
        castellans = {}
        @castellans.each do |castellan|
          buy_status = if current_user.coins < castellan.price
            0 #没钱购买
          elsif castellan.user_castellan.nil?
            3
          elsif castellan.user_castellan.user_id == current_user.id
            1 #已经购买
          else
            2 #可以购买
          end

          buy_status = 4 if bought_castellan
              
          castellans[castellan.id] = {:user_name => castellan.user_castellan.nil? ? '' : "竞拍者：#{castellan.user_castellan.user_name}",
                                     :price => castellan.price,
                                     :buy_status => buy_status}
        end
        render :json => { :castellans => castellans, :left_times => @left_times}
      end
    end
  end

  def auction_prince
    _price = params[:price].to_i
    render :json => false if current_user.coins < _price
    castellan = Games::Gcld::Castellan.find(params[:castellan_id])
    current_castellan = castellan.user_castellan
    old_price = current_castellan.price if current_castellan
    user_castellan = Games::Gcld::UserCastellan.create(:user => current_user, :castellan => castellan, :price => _price)
    current_price = user_castellan.price
    Message::SysMessage.create(:receiver => current_user, :content => '您已竞拍成功，请等待竞拍结果！')
    if current_castellan.nil?
      castellan.set(:user_castellan_id => user_castellan.id)
      castellan.set(:user => current_user.id)
      castellan.inc(:price => 100)
    else
      if current_price > old_price
        current_user.inc(:coins => -_price)
        castellan.user.inc(:coins => old_price)
        Message::SysMessage.create(:receiver => castellan.user, :content => '您竞拍的xx已经倍更高价格买走，请重新竞拍！')
        castellan.set(:user_castellan_id => user_castellan.id)
        castellan.set(:user => current_user.id)
        castellan.inc(:price => 100)
      end
    end    
    castellan.save!
    castellan.reload

    render :json => {:user_name => castellan.user_castellan.user.name, :new_price => _price}
  end

  def auction_general
    _price = params[:price].to_i
    render :json => false if current_user.coins < _price
    castellan = Games::Gcld::Castellan.find(params[:castellan_id])
    current_castellan = castellan.user_castellan
    old_price = current_castellan.price if current_castellan
    user_castellan = Games::Gcld::UserCastellan.create(:user => current_user, :castellan => castellan, :price => _price)
    current_price = user_castellan.price
    Message::SysMessage.create(:receiver => current_user, :content => '您已竞拍成功，请等待竞拍结果！')
    if current_castellan.nil?
      castellan.set(:user_castellan_id => user_castellan.id)
      castellan.set(:user => current_user.id)
      castellan.inc(:price => 100)
    else
      if current_price > old_price
        current_user.inc(:coins => -_price)
        castellan.user.inc(:coins => old_price)
        Message::SysMessage.create(:receiver => castellan.user, :content => '您竞拍的xx已经倍更高价格买走，请重新竞拍！')
        castellan.set(:user_castellan_id => user_castellan.id)
        castellan.set(:user => current_user.id)
        castellan.inc(:price => 100)
      end
    end    
    castellan.save!
    castellan.reload

    render :json => {:user_name => castellan.user_castellan.user.name, :new_price => _price}
  end


  def search_auction_generals
    influence_ids = Games::Gcld::Castellan.where(:role_type_id => 2100, :user_id.ne => nil).map &:influence_id
    
    @influences = Games::Gcld::Influence.where(:db_id.in => influence_ids)


    name = params[:name] if params[:name]

    @castellans = Games::Gcld::Castellan.where(:role_type_id => 2200, :influence_id.in => influence_ids, :name => /#{name}/).desc(:created_at).paginate :page => params[:page], :per_page => 14

    bought_castellan = Games::Gcld::Castellan.where(:role_type_id => 2100, :user_id => current_user.id).first

    gon.user_money = current_user.coins
    gon.castellans_info = {}

    @left_times = (Games::Gcld::Castellan.zhaizhu_auction_times.value.to_i-(Time.now.to_i - Games::Gcld::Castellan.start_auction_at.value))
    return render :text => '竞拍还没有开始，请等待！' if @left_times < 0
    # @left_times = "#{@left_times/60}:#{@left_times%60}"
    yushu = @left_times%60
    yushu = '0'+yushu.to_s if yushu.to_s.length == 1
    @left_times = "#{@left_times/60}:#{yushu}"


    respond_to do |format|
      format.html do
        @castellans.each do |castellan|
          gon.castellans_info[castellan.id] = {:id => castellan.id, 
                                    :db_id => castellan.db_id, 
                                    :name => castellan.name,
                                    :tong_shuai => castellan.tong_shuai, 
                                    :wu_li => castellan.wu_li,
                                    :zhi_li => castellan.zhi_li,
                                    :zheng_zhi => castellan.zheng_zhi}
        end
        render :layout => false if params[:pjax]
        render :layout => false, :action => 'auction_generals_index'
      end
      format.json do
        castellans = {}
        @castellans.each do |castellan|
          buy_status = if current_user.coins < castellan.price
            0 #没钱购买
          elsif castellan.user_castellan.nil?
            3
          elsif castellan.user_castellan.user_id == current_user.id
            1 #已经购买
          else
            2 #可以购买
          end

          buy_status = 4 if bought_castellan
              
          castellans[castellan.id] = {:user_name => castellan.user_castellan.nil? ? '' : "竞拍者：#{castellan.user_castellan.user_name}",
                                     :price => castellan.price,
                                     :buy_status => buy_status}
        end
        render :json => { :castellans => castellans, :left_times => @left_times}
      end
    end

  end

  def auction_generals_index

    influence_ids = Games::Gcld::Castellan.where(:role_type_id => 2100, :user_id.ne => nil).map &:influence_id

    p '!!!!!'
    p influence_ids

    @influences = Games::Gcld::Influence.where(:db_id.in => influence_ids)

    @influence = Games::Gcld::Influence.find(params[:influence_id]) if params[:influence_id]

    if @influence
      @castellans = Games::Gcld::Castellan.where(:role_type_id => 2200, :influence_id => @influence.db_id).desc(:created_at).paginate :page => params[:page], :per_page => 14
    else
      @castellans = Games::Gcld::Castellan.where(:role_type_id => 2200, :influence_id.in => influence_ids).desc(:created_at).paginate :page => params[:page], :per_page => 14
    end

    bought_castellan = Games::Gcld::Castellan.where(:role_type_id => 2100, :user_id => current_user.id).first

    gon.user_money = current_user.coins
    gon.castellans_info = {}

    @left_times = (Games::Gcld::Castellan.zhaizhu_auction_times.value.to_i-(Time.now.to_i - Games::Gcld::Castellan.start_auction_at.value))

    return render :text => '竞拍还没有开始，请等待！' if @left_times < 0
    yushu = @left_times%60
    yushu = '0'+yushu.to_s if yushu.to_s.length == 1
    @left_times = "#{@left_times/60}:#{yushu}"

    respond_to do |format|
      format.html do
        @castellans.each do |castellan|
          gon.castellans_info[castellan.id] = {:id => castellan.id, 
                                    :db_id => castellan.db_id, 
                                    :name => castellan.name,
                                    :tong_shuai => castellan.tong_shuai, 
                                    :wu_li => castellan.wu_li,
                                    :zhi_li => castellan.zhi_li,
                                    :zheng_zhi => castellan.zheng_zhi}
        end
        render :layout => false if params[:pjax]
        render :layout => false
      end
      format.json do
        castellans = {}
        @castellans.each do |castellan|
          buy_status = if current_user.coins < castellan.price
            0 #没钱购买
          elsif castellan.user_castellan.nil?
            3
          elsif castellan.user_castellan.user_id == current_user.id
            1 #已经购买
          else
            2 #可以购买
          end

          buy_status = 4 if bought_castellan
              
          castellans[castellan.id] = {:user_name => castellan.user_castellan.nil? ? '' : "竞拍者：#{castellan.user_castellan.user_name}",
                                     :price => castellan.price,
                                     :buy_status => buy_status}
        end
        render :json => { :castellans => castellans, :left_times => @left_times}
      end
    end
  end

end
