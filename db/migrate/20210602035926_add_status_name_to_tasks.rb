class AddStatusNameToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :status_name, :integer, null: false, default: 1
  end
end
