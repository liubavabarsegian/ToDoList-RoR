class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :description
      t.date :due
      t.boolean :reminder
      t.time :reminder_time
      t.boolean :completed

      t.timestamps
    end
  end
end
