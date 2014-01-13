require 'spec_helper'

describe SysHero do

  describe 'Validates' do
    it 'should fail saving without name' do
      sys_meta_hero = SysHero.new
      sys_meta_hero.save.should be_false
    end
  end

  it 'show name method' do
    sys_meta_hero = SysMetaHero.create(:name => 'Hero_1', :talent => 0)
    sys_hero = sys_meta_hero.sys_heros.create(:name => sys_meta_hero.name)
    sys_hero.show_name.should == 'Hero_1(1--1)'
  end
end
