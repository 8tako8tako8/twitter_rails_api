# frozen_string_literal: true

class AddTmpToTweets < ActiveRecord::Migration[7.0]
  def change
    add_column :tweets, :tmp, :string
  end
end
