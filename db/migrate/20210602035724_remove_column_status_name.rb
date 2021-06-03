class RemoveColumnStatusName < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :status_name
  end
end
