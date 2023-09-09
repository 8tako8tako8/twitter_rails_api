# frozen_string_literal: true

class CreateTweets < ActiveRecord::Migration[7.0]
  def change
    create_table :tweets do |t|
      t.string 'tweet', limit: 200, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
