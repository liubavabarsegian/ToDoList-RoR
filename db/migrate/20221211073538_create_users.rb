# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :nick, null: false
      t.string :name
      t.string :surname
      t.string :email, null: false
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
