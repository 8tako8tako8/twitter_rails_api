# frozen_string_literal: true

class Group < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
end
