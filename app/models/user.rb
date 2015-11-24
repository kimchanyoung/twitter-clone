class User < ActiveRecord::Base
  has_secure_password

  has_many :tweets
  has_many :followings, class_name: 'Follow', foreign_key: 'follower_id', dependent: :destroy
  has_many :followees, through: :followings, source: :followee
  has_many :followeds, class_name: 'Follow', foreign_key: 'followee_id', dependent: :destroy
  has_many :followers, through: :followeds, source: :follower

  validates :username, uniqueness: true, presence: true

  def relevant_tweets
    Tweet.where(user_id: (followees.pluck(:id) + [id])).order("created_at DESC").limit(50)
  end
end
