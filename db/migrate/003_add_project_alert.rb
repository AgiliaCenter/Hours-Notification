class AddProjectAlert < ActiveRecord::Migration
  def change
  	add_column :alerts , :project_id , :integer
  end
end
