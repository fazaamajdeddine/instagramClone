class Follow < ApplicationRecord
    
    #belongs_to :user

    belongs_to :follower, class_name: 'User'
    belongs_to :followed, class_name: 'User'

    validates :follower_id, presence: true
    validates :followed_id, presence: true

    #The two validations  are to ensure a user can only follow another user once and a user can only have one follow from another user.(line 8&9)
end
