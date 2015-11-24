class CreateHashtagTweets < ActiveRecord::Migration
  def change
    create_table :hashtag_tweets do |t|
      t.integer :hashtag_id, null: false
      t.integer :tweet_id, null: false

      t.timestamps null: false
    end
  end
end
