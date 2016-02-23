
module HoursNotification
    module Patches
        module ProjectPatch
            def self.included(base)
                base.class_eval do
                    safe_attributes 'estimated_hours'

                    has_many :notification
                    has_many :roles , :through => :notification

                    validates :estimated_hours , :numericality => {:greater_than => 0} 
                end
            end
        end
    end
end