class ChangeDefaultLimitOfTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :limit, :date, null: false,
    default: -> { "now() + cast( '1 months' as INTERVAL )" }
  end
end
