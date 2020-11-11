# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  name            :string           not null
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  google_user_id  :string
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
 
    validates :google_user_id, 
        presence: true, 
        numericality: { only_integer: true, greater_than: 0 },
        uniqueness: true,
        unless: :password_digest?
    
    with_options unless: :google_user_id? do |secure_password|
        # Adapted from: https://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html#method-i-has_secure_password
        secure_password.validate :add_missing_password_error
        
        secure_password.validates :password, 
            length: { minimum: 8, maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED }, 
            confirmation: { allow_blank: true }
    end

private
    def add_missing_password_error
        return if password_digest?
        record.errors.add(:password, :blank) 
    end

end
