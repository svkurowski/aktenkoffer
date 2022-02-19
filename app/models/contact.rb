class Contact < ApplicationRecord
  include ActionView::Helpers

  validates :name, presence: true, uniqueness: true

  def home?
    self == ApplicationController.helpers.home_contact
  end
end
