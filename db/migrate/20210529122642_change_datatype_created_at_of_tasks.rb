class ChangeDatatypeCreatedAtOfTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :created_at, :date, null: false
  end
end
