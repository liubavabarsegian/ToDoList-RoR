# frozen_string_literal: true

class AddSoundsForUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :success_sound, :string, default: 'si'
    add_column :users, :failure_sound, :string, default: 'wahwahwah'
  end
end
