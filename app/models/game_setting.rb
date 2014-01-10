class GameSetting < Settingslogic
  source "#{Rails.root}/config/game_setting.yml"
  # namespace Rails.env
  # load! if Rails.env.development?
end
