class AddHoursProject < ActiveRecord::Migration
  def change
    add_column :projects, :estimated_hours, :float
  end
end