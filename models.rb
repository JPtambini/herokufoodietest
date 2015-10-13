class User < ActiveRecord::Base
	has_many :posts
    has_many :follows, foreign_key: :followee_id
    has_many :followings, foreign_key: :follower_id, class_name: "::Follow"
    has_many :followers, through: :follows, class_name: User
    has_many :followees, through: :followings, class_name: User
 # has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
   # validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end

class Post < ActiveRecord::Base
	belongs_to :user
   # has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
   # validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end

class Follow < ActiveRecord::Base
    belongs_to :follower, foreign_key: :follower_id, class_name: User
    belongs_to :followee, foreign_key: :followee_id, class_name: User
end
