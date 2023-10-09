# frozen_string_literal: true

class ChangeCommentLengthInComments < ActiveRecord::Migration[7.0]
  def up
    change_column :comments, :comment, :string, limit: 200
  end

  def down
    change_column :comments, :comment, :string, limit: nil
  end
end
