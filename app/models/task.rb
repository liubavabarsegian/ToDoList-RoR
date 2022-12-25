# frozen_string_literal: true

class Task < ApplicationRecord
  validates :title, presence: true
  belongs_to :user
  # actually it returns due date, but i need this variable to be
  # name as start_time cuz i want to use task model as event
  def start_time
    due
  end
end
