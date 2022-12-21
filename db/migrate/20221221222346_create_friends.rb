class CreateFriends < ActiveRecord::Migration[7.0]
  def change
    create_table :friends do |t|
      t.boolean :incoming_request
      t.boolean :sent_request
      t.boolean :friendship
      t.integer :friend_id, null: false
      t.timestamps
    end

    
  end
end
