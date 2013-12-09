# coding: utf-8
class BaseCell < Cell::Rails
  helper :application, :users, 'Bbs::Topics', :locations
end
