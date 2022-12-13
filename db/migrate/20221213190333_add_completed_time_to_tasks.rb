class AddCompletedTimeToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :completed_time, :datetime
  end
end
