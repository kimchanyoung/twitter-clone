class Tweet < ActiveRecord::Base
  has_many :hashtag_tweets
  has_many :hashtags, through: :hashtag_tweets
  belongs_to :user
end
