class CreateNotification < ActiveRecord::Migration
	def change
  		create_table :notifications do |t|

    		t.integer :project_id

    		t.integer :role_id

    	end
    end
end
