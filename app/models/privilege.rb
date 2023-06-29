class Privilege < ApplicationRecord
  belongs_to :role
  belongs_to :mod

  validates :mod_id, uniqueness: {scope: :role_id}
end
