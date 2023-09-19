# frozen_string_literal: true

class AddDetailsToUsers < ActiveRecord::Migration[7.0]
  change_table :users, bulk: true do |t|
    t.text :website_url
    t.date :birthdate
    t.string :location
    t.string :introduction
  end
end
