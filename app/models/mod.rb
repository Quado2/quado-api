class Mod < ApplicationRecord
  has_many: :privileges

  validates :name, uniqueness: ({case_sensitive: false}), presence: true, type: string
end
