class Post < ApplicationRecord
    has_one_attached :image
    belongs_to :user
    has_many :comments, dependent: :destroy
    acts_as_votable
    
def thumbnail 
    return self.image.variant(resize: '500x500!').processed
end

def profile_thumbnail
    return self.image.variant(resize: '350x350!').processed
end
    
    
  
end
