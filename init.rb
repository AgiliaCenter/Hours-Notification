
require_dependency 'Hours_Notification_Hooks'
require_dependency 'project_path'
require_dependency 'role_path'
require_dependency 'time_entry_path'

Redmine::Plugin.register :hoursnotification do

  name 'Hours-Notification plugin'
  author 'AgiliaCenter'
  description 'This is a plugin for Redmine to add estimate time to a project and configure some alerts when you reach a percentage.'
  version '1.0.0'
  url ''
  author_url 'http://agiliacenter.com'

  project_module :hoursnotification do
    permission :manage_notification_projects,
                { :alerts => [:index, :create] }
  end

  #permission :hoursnotification, { :hoursnotification => [:index, :edit] }, :public => true
  menu :project_menu, :hoursnotification, { :controller => 'alerts', :action => 'index' }, :caption => :plugin_title , 
       :after => :settings , :param => :project_id


  Rails.configuration.to_prepare do

    TimeEntry.send(:include, HoursNotification::Patches::TimeEntryPatch)
    Project.send(:include, HoursNotification::Patches::ProjectPatch)
    Role.send(:include, HoursNotification::Patches::RolePatch)
  end
end
