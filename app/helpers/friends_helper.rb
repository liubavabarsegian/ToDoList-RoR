# frozen_string_literal: true

# friends helper
module FriendsHelper
  # rubocop:disable Layout/LineLength
  def requests
    Friend.all.where(friend1: current_user.id,
                     relationship: 'request').or(Friend.all.where(friend2: current_user.id,
                                                                  relationship: 'request')).where.not(who_sent_request: current_user.id)
  end

  def friends
    redirect_to login_path unless user_signed_in?
    Friend.all.where(friend1: current_user.id).or(Friend.where(friend2: current_user.id)).where(relationship: 'friendship')
  end
  # rubocop:enable Layout/LineLength

  def are_friends?(user1, user2)
    !Friend.where(friend1: user1.id,
                  friend2: user2.id).or(Friend.where(friend1: user2.id,
                                                     friend2: user1.id)).where(relationship: 'friendship').empty?
  end

  def find_friend(user2)
    Friend.where(friend1: current_user.id,
                 friend2: user2.id).or(Friend.where(friend2: current_user.id,
                                                    friend1: user2.id)).where(relationship: 'friendship').first
  end

  def find_request(from, to)
    Friend.where(friend1: from.id, friend2: to.id).or(Friend.where(friend1: to.id, friend2: from.id)).where(
      relationship: 'request', who_sent_request: from.id
    ).first
  end

  def second_user(user1, user2)
    return user1 if user1 != current_user
    return user2 if user2 != current_user
  end
end
