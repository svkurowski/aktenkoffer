class Document < ApplicationRecord
  belongs_to :sender, class_name: 'Contact', optional: true
  belongs_to :recipient, class_name: 'Contact', optional: true

  has_one_attached :original_file
end
