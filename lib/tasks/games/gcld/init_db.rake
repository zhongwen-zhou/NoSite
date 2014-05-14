namespace :games do
	namespace :gcld do
		  desc 'Clear caches in memcached'
		  task :init_db => :environment do
		  	Games::Gcld::Role.create(:db_id => 1500, :name => '玩家')
		  	Games::Gcld::Role.create(:db_id => 1600, :name => 'NPC')


		  	Games::Gcld::RoleType.create(:db_id => 2100, :name => '主公')
		  	Games::Gcld::RoleType.create(:db_id => 2200, :name => '债主')
		  	Games::Gcld::RoleType.create(:db_id => 2300, :name => '武将')


		  	Games::Gcld::RoleBzType.create(:db_id => 3100, :name => '弓')
		  	Games::Gcld::RoleBzType.create(:db_id => 3200, :name => '骑')
		  	Games::Gcld::RoleBzType.create(:db_id => 3300, :name => '枪')
		  	Games::Gcld::RoleBzType.create(:db_id => 3400, :name => '盾')


				shi_li = %w"献帝 张角 袁绍 刘备 孔融 司马懿 刘表 陶谦 严白虎 张鲁 公孙度 马腾 刘璋 孙权 曹操 公孙瓒 董卓 韩遂 孟获 何进 在野"
				shi_li.each_with_index do |sl, index|
					Games::Gcld::Influence.create(:db_id => (index + 1), :name => sl)
				end

				Games::Gcld::CityType.create(:db_id => 4100, :name => '都城')
				Games::Gcld::CityType.create(:db_id => 4200, :name => '山寨紫')
				Games::Gcld::CityType.create(:db_id => 4300, :name => '山寨蓝')
				Games::Gcld::CityType.create(:db_id => 4400, :name => '山寨绿')

				juse_file = File.read 'db/games/gcld/juese.json'
				juse_jsons = JSON.parse(juse_file)
				juse_jsons.each do |juese|
					Games::Gcld::Castellan.create(juese)
				end
		  end
  	end
end
