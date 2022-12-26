# frozen_string_literal: true

class RenameFriendsColumns < ActiveRecord::Migration[7.0]
  def change
    rename_column :friends, :friend_1, :friend1
    rename_column :friends, :friend_2, :friend2
  end
end
