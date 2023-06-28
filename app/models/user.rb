class User < ApplicationRecord
  has_secure_password
  attr_accessor :role_id

  has_many :user_roles, autosave: true
  has_many :roles, through: :user_roles, dependent: :destroy

  validates :email, presence: true, uniqueness: {case_sensitive: false},
    format: {with: /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/, message: 'is invalid!', multiline: true }
  
  validates :phone_number, presence: true, uniqueness: true,
  format: { with: /^(?:(?:(?:\+?234(?:\h1)?|01)\h*)?(?:\(\d{3}\)|\d{3})|\d{4})(?:\W*\d{3})?\W*\d{4}$/,
  multiline: true }

  before_save :trim_phone_number

  def trim_phone_number
    phone_number.slice!(0) if  phone_number[0] == '0'
    phone_number.slice(0,3) if phone_number[0] == '+' || phone_number.size >= 13
  end

end