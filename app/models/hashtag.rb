class Hashtag < ActiveRecord::Base
  has_many :hashtag_tweets
  has_many :tweets, through: :hashtag_tweets

  def to_param
    name.to_s
  end
end
