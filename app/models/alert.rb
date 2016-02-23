class Alert < ActiveRecord::Base
  unloadable

  belongs_to :project

  validates :project , presence:true
  validates :percentage , :numericality => {:greater_than_or_equal_to => 0 , :less_than_or_equal_to => 100}
  validates :percentage , presence:true

end
