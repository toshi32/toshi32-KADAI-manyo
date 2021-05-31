class AddStatusToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :status_name, :string, default: 1, null: false
  end
end
