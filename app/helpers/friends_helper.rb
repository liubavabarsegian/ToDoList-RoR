module FriendsHelper
    def requests
        Friend.all.where(friend_1: current_user.id, relationship: 'request').or(Friend.all.where(friend_2: current_user.id, relationship: 'request')).where.not(who_sent_request: current_user.id)
    end

    def friends
        Friend.all.where(friend_1: current_user.id).or(Friend.where(friend_2: current_user.id)).where(relationship: 'friendship')
    end

    def are_friends?(user1, user2)
        !Friend.where(friend_1: user1.id, friend_2: user2.id).or(Friend.where(friend_1: user2.id, friend_2: user1.id)).where(relationship: 'friendship').empty?
    end

    def find_friend(user2)
        Frind.where(friend_1: current_user.id, friend_2: user2.id).or(Frind.where(friend_1: current_user.id, friend_2: user2.id)).where(relationship: 'friendship').first
    end

    def find_request(from, to)
        Friend.where(friend_1: from.id, friend_2: to.id).or(Friend.where(friend_1: to.id, friend_2: from.id)).where(relationship: 'request', who_sent_request: from.id).first
    end

    def second_user(user1, user2)
        return user1 if user1 != current_user
        return user2 if user2 != current_user
    end

    def friend?(user1)
        
    end
end
