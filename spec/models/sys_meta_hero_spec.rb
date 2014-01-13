require 'spec_helper'

describe SysMetaHero do

  describe 'Validates' do
    it 'should fail saving without name' do
      sys_meta_hero = SysMetaHero.new
      sys_meta_hero.save.should be_false
    end

    it 'should fail saving with an exist name' do
      SysMetaHero.create(:name => 'test hero', :talent => 0)
      sys_meta_hero = SysMetaHero.new(:name => 'test hero', :talent => 0)
      sys_meta_hero.save.should be_false
    end 
  end

  describe 'set star upgrade' do
    it 'add star level and set details' do
      sys_meta_hero = SysMetaHero.create(:name => 'Hero_1', :talent => 0)
      # sys_meta_hero.sys_heros.create
    end
  end
end
