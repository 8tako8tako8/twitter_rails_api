# frozen_string_literal: true

class NilUserUpdater
  def self.update_nil_users
    users = User.where(name: nil).or(User.where(nickname: nil))

    users.find_each do |user|
      name = user.name || generate_unique_token(:name)
      nickname = user.nickname || generate_unique_token(:nickname)

      user.update(name:, nickname:)
    end
  end

  def self.generate_unique_token(attribute)
    loop do
      token = SecureRandom.hex(8)
      break token unless User.exists?(attribute => token)
    end
  end
end

NilUserUpdater.update_nil_users
