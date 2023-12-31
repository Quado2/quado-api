class User < ApplicationRecord
  has_secure_password validations: false

  attr_accessor :role_id

  has_many :user_roles
  has_many :roles, through: :user_roles, dependent: :destroy



end