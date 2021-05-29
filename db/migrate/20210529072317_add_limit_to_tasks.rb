class AddLimitToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :limit, :date, null: false, default: Time.now.strftime("%Y-%m-%d")
  end
end
