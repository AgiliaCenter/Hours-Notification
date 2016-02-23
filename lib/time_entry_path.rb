module HoursNotification
    module Patches
        module TimeEntryPatch
            def self.included(base)
            	base.send(:include, InstanceMethods)

                base.class_eval do
                	unloadable

                	after_save :check_project_hours
                end
            end
        end
        module InstanceMethods

          def check_project_hours
            project = TimeEntry.find(self).project

            if project.module_enabled?("hoursnotification")

             estimated_hours = project.estimated_hours

             if !estimated_hours.nil?
              total_hours = TimeEntry.visible.where(project_id: project.id).sum(:hours).to_f
              ratio = ((total_hours / estimated_hours ) * 100)
              alert = Alert.where(:email_sent => 0 , :project_id => project.id).where("percentage <= ?", ratio).last

              if !alert.nil?
                project_roles = Notification.select(:role_id).where(:project_id => project.id).map { |value| value['role_id'] } 
                mails = []

                project_roles.each do | role_id|
                  role = Role.find(role_id)
                  project_members = project.members.joins(:roles).where("roles.id = ?" , role.id).all
                  
                  project_members.each do | member|

                    if not mails.include?(member.user.mail)
                      mails << member.user.mail
                    end
                  end
                end

                HoursMailer.send_email(mails , project , alert ,total_hours).deliver

                alert.email_sent = true
                alert.save 

             end  
           end    				
         end
       end
     end
   end
end