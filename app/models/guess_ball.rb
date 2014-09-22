class GuessBall
  include Mongoid::Document
  include Mongoid::BaseModel

  field :index_date, :type => Date
  
  field :g1_team1, :type => String, :default => ""
  field :g1_team2, :type => String, :default => ""
  field :g2_team1, :type => String, :default => ""
  field :g2_team2, :type => String, :default => ""

  field :g1_result, :type => Integer, :default => -1
  field :g2_result, :type => Integer, :default => -1

  field :last_result, :type => String, :default => ""
  
end