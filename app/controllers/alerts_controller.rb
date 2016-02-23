class AlertsController < ApplicationController
  unloadable

  before_filter :find_project , :authorize ,:only => [:index ,:create]

  # GET /projects/:project_id/notifications
  def index
  	@alerts = Alert.where(project_id: @project.id).all()
    @selected_values = Array(Alert.where(project_id: @project.id).select(:percentage).map { |value| value['percentage']})
    @roles = @project.users_by_role
    @selected_roles = @project.notification.joins(:role).select(:name).map { |value| value['name'] } 
    total_hours = TimeEntry.visible.where(project_id: @project.id).sum(:hours).to_f
    estimated_hours = @project.estimated_hours

    if not estimated_hours.nil?
      ratio = ((total_hours / estimated_hours ) * 100)
    else
      ratio = -5   
    end

    (0..100).step(5).each do |item|
        @start_range = item if item-5 <= ratio and item >= ratio
    end
  end

  # POST /projects/:project_id/notification
  def create

    if params[:roles].blank?
      flash[:error] = l(:no_role_selected)
      redirect_to :back
      return

    end

    if params[:percentage].blank? and not params[:roles].blank?
      flash[:error] = l(:no_alert_selected)
      redirect_to :back
      return
    end

    Alert.where(:project_id => @project.id, :email_sent => 0).destroy_all
    Array(params[:percentage]).each do |item|
      alert = Alert.new
      alert.project = @project
      alert.percentage = item
      alert.save
    end

    Notification.where(:project_id => @project.id).destroy_all

    Array(params[:roles]).each do |role_name|
      role = Role.find_by_name(role_name)
      @project.roles << role
      @project.save    
    end

    flash[:notice] = l(:changes_saved)
    redirect_to :back
  end

private

	def find_project
		@project = Project.find(params[:project_id])
	end
end
