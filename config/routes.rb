# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

get '/projects/:project_id/notifications' , :to => 'alerts#index' , :as => 'project_notification'
#put '/projects/:project_id/notifications/:notification_id' , :to => 'alerts#update' , :as => 'project_notification_update'
#get '/projects/:project_id/notifications/:notification_id' , :to => 'alerts#edit' , :as => 'project_notification_edit'
post '/projects/:project_id/notification' , :to => 'alerts#create' , :as => 'project_notification_create'
#delete '/projects/:project_id/notification/notification_delete' , :to => 'alerts#create' , :as => 'project_notification_delete'