# frozen_string_literal: true

class ChangeLocationAndIntroductionLengthInUsers < ActiveRecord::Migration[7.0]
  change_table :users, bulk: true do |t|
    t.change :location, :string, limit: 10
    t.change :introduction, :string, limit: 100
  end
end
