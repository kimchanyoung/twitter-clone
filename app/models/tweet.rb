class Tweet < ActiveRecord::Base
  has_many :hashtag_tweets
  has_many :hashtags, through: :hashtag_tweets
  belongs_to :user

  validates :content, presence: true

  def hashtag_names
    self.hashtags.pluck(:name)
  end
end
