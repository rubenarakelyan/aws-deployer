class User < ApplicationRecord
  def self.find_or_create_from_auth_hash(auth_hash)
    return false unless auth_hash.credentials.team_member?

    where(email: auth_hash.info.email).first_or_initialize do |user|
      user.email = auth_hash.info.email
      user.name = auth_hash.info.name
      user.avatar_url = auth_hash.info.image
      user.save!
    end
  end
end
