class Tweet < ActiveRecord::Base
  has_many :hashtag_tweets
  has_many :hashtags, through: :hashtag_tweets
  belongs_to :user

  validates :content, presence: true

  def hashtag_names
    self.hashtags.pluck(:name)
  end

  def self.ordered_json(user)
    includes(:follows).where(follows: {followee_id: user.id}).order("created_at DESC").limit(50).to_json(methods: :hashtag_names)
  end
end
