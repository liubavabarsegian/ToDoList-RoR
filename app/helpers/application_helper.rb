# frozen_string_literal: true

# app helper
module ApplicationHelper
  # rubocop:disable Layout/LineLength
  def requests
    Friend.all.where(friend1: current_user.id,
                     relationship: 'request').or(Friend.all.where(friend2: current_user.id,
                                                                  relationship: 'request')).where.not(who_sent_request: current_user.id)
  end
  # rubocop:enable Layout/LineLength
end
