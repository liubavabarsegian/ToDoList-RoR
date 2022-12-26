# frozen_string_literal: true

# task
class Task < ApplicationRecord
  belongs_to :user
  validates_presence_of :title, message: I18n.t(:cannot_be_blank)
  # actually it returns due date, but i need this variable to be
  # name as start_time cuz i want to use task model as event
  def start_time
    due
  end
end
