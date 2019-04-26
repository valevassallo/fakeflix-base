class User < ApplicationRecord
  has_secure_password
  has_secure_token

  def invalidate_token
    update(token: nil)
  end

  def self.valid_login?(email, password)
    user = find_by(email: email)
    user if user && user.authenticate(password)
  end

  def admin?
    role == "admin"
  end

  def regular?
    role == "regular"
  end
end

# == Schema Information
#
# Table name: users
#
#  id                   :bigint(8)        not null, primary key
#  authentication_token :string(30)       indexed
#  email                :string
#  name                 :string
#  password_digest      :string
#  role                 :string
#  token                :string           indexed
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_users_on_authentication_token  (authentication_token) UNIQUE
#  index_users_on_token                 (token) UNIQUE
#
