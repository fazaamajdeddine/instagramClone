class Post < ApplicationRecord
    has_one_attached :image
    belongs_to :user
    has_many :comments, dependent: :destroy
    acts_as_votable
    has_many :post_hash_tags
    has_many :hash_tags, through: :post_hash_tags
    
def thumbnail 
    return self.image.variant(resize: '500x500!').processed
end

def profile_thumbnail
    return self.image.variant(resize: '350x350!').processed
end
    
after_commit :create_hash_tags, on: :create
def create_hash_tags
    extract_name_hash_tags.each do |name|
      hash_tags.create(name: name)
    end
  end
def extract_name_hash_tags
    caption.to_s.scan(/#\w+/).map{|name| name.gsub("#", "")}
  end
end
