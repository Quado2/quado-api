class Mod < ApplicationRecord
  has_many :privileges, dependent: :destroy

  validates :name, uniqueness: ({case_sensitive: false}), presence: true
end
