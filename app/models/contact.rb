class Contact < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
