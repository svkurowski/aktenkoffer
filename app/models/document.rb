class Document < ApplicationRecord
  belongs_to :sender, class_name: 'Contact', optional: true
  belongs_to :recipient, class_name: 'Contact', optional: true
end
