# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  name            :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    has_secure_password
    
    has_many :ratings
    has_many :recipes, through: :ratings
end
