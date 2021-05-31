class RemoveColumnLimit < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :limit
  end
end
