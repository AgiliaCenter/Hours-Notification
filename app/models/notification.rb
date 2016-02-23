class Notification < ActiveRecord::Base
  unloadable

  belongs_to :project
  belongs_to :role

end