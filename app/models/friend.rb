# frozen_string_literal: true

class Friend < ApplicationRecord
  # belongs_to :user

  validates :friend_1, :friend_2, presence: true
end
