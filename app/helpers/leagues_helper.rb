module LeaguesHelper
  def can_send_message?(league)
  	return false if league.present?
  	league.president == current_user
  end

	def can_publish_message?(league)
		return false unless league.present?
		member = league.members.find(current_user.id)
		return true if member.is_admin? || member.role == 2
		return false
	end
end