class CreateHashtagTweets < ActiveRecord::Migration
  def change
    create_table :hashtag_tweets do |t|

      t.timestamps null: false
    end
  end
end
