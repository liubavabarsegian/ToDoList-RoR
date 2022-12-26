# frozen_string_literal: true

# friend
class Friend < ApplicationRecord
  validates_presence_of :friend1, :friend2, message: I18n.t(:cannot_be_blank)
end
