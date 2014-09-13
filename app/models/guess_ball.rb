require 'singleton'
class GuessBall
	include Singleton
	attr_accessor :g1_team1, :g1_team2, :g2_team1, :g2_team2, :g1_result, :g2_result, :last_result, :last_updated_at
end