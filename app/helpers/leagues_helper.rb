module LeaguesHelper
  def can_send_message?(league)
  	return false if league.present?
  	league.president == current_user
  end
end