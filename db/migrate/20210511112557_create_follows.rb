class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      t.integer "follower_id"
      t.integer "followed_id"
      t.timestamps
    end
    add_index :follows, :follower_id                                    #a user can’t 
    add_index :follows, :followed_id                                    #follow another
    add_index :follows, [ :follower_id , :followed_id ], unique: true   # user more than once
    
  end
end
