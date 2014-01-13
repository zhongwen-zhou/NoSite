FactoryGirl.define do
  factory :sys_meta_hero do
  #   sequence(:name){|n| "name#{n}" }
  #   sequence(:login){|n| "login#{n}" }
  #   sequence(:email){|n| "email#{n}@ruby-china.org" }
    name 'Hero_1'
    talent '0'
  #   password_confirmation 'password'
  #   location "China"
  #   created_at 100.days.ago
  #   verified false
  end

  factory :sys_hero do
    hp 100
  end

  # factory :wiki_editor, :parent => :user do
  #   verified true
  # end

  # factory :non_wiki_editor, :parent => :user do
  #   verified false
  # end

  # factory :newbie, :parent => :user do
  #   created_at 1.days.ago
  # end

  # factory :blocked_user, :parent => :user do
  #   created_at 30.days.ago
  #   state 2
  # end

  # factory :deleted_user, :parent => :user do
  #   created_at 100.days.ago
  #   state -1
  # end
end
