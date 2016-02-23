
module HoursNotification
    module Patches
        module RolePatch
            def self.included(base)
                base.class_eval do

                    has_many :notification
                    has_many :project , :through => :notification
                end
            end
        end
    end
end