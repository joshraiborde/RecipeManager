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
    has_many :ratings
    has_many :recipes, through: :ratings
    
    has_secure_password validations: false


    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
 
    # Adapted from: https://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html#method-i-has_secure_password
    validate :add_missing_password_error, unless: :password_digest? # TODO: add unless for if we have external login
    
    validates :password, 
        length: { minimum: 8, maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED }, 
        confirmation: { allow_blank: true }
    
private
    def add_missing_password_error
        record.errors.add(:password, :blank) 
    end

end
