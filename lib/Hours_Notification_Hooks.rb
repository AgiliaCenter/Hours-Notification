# Plugin hooks. Checks here => http://www.redmine.org/projects/redmine/wiki/Hooks_List
class HoursNotificationHooks < Redmine::Hook::ViewListener

	# Creates a estimated hours field when a project is being created/edited.
	render_on :view_projects_form , :partial => 'project/form'

	# Renders stimated hours on the project summary left sidebar
	render_on :view_projects_show_sidebar_bottom , :partial => 'project/summary'
end