# frozen_string_literal: true

class ChangeColumnsOnUsers < ActiveRecord::Migration[7.0]
  change_table :users, bulk: true do |t|
    t.change_null :name, false
    t.change_null :nickname, false
    t.index ['name'], unique: true
  end
end
