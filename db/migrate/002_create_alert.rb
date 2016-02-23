class CreateAlert < ActiveRecord::Migration
  def change
    create_table :alerts do |t|

    	# % of hours consumed before the trigger is fired.
    	t.integer :percentage

    	# Indicates if the email has been sent
    	t.boolean :email_sent , :default => false   		
    end
  end
end
