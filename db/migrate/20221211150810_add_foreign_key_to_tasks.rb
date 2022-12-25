# frozen_string_literal: true

class AddForeignKeyToTasks < ActiveRecord::Migration[7.0]
  def change
    add_reference :tasks, :user
  end
end
