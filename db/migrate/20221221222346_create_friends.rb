# frozen_string_literal: true

class CreateFriends < ActiveRecord::Migration[7.0]
  def change
    create_table :friends do |t|
      t.integer :friend_1, null: false
      t.integer :friend_2, null: false
      t.string :relationship
      t.integer :who_sent_request
      t.timestamps
    end
  end
end
