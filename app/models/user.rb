class User < ApplicationRecord
  has_one_attached :avatar
  has_many :posts 
  validates :username, presence: true 
  has_many :comments, dependent: :destroy
  
   # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

#belongs_to :follow, class: 'User'


has_many :active_follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy 

has_many :passive_follows, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy

has_many :following, through: :active_follows, source: :followed,  class_name: "User"
has_many :followers, through: :passive_follows, source: :follower, class_name: "User"

def follow(user)
  active_follows.create(followed_id: user.id)
end

def unfollow(user)
  active_follows.find_by(followed_id: user.id).destroy 
end



def full_name
  "#{first_name} #{last_name}"
end


acts_as_voter


def self.search(term)
  if term
    where('username LIKE ?', "%#{term}%")
  else
    nil
  end
end

after_commit :add_avatar, on: %i[create update]

def avatar_thumbnail 
  if avatar.attached?
    avatar.variant(resize:"150X150!").processed 
  else 
    "avatar.png"
  end
end

private 
def add_avatar 
  unless avatar.attached? 
    avatar.attach(
      io: File.open(
        Rails.root.join(
          'app', 'assets', 'images', 'avatar.png'
        )
      ), 
      filename: 'avatar.png',
      content_type: 'image/png'
    )
  end
end
end
