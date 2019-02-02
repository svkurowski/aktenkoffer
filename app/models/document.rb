class Document < ApplicationRecord
  belongs_to :sender, class_name: 'Contact', optional: true
  belongs_to :recipient, class_name: 'Contact', optional: true

  has_one_attached :original_file

  def acted_at
    received_at || sent_at || created_at.to_date
  end

  def self.order_by_acted_at(dir = 'DESC')
    dir = if ['ASC', 'DESC'].include? dir then dir else 'DESC' end
    order("COALESCE(received_at, sent_at, created_at::date) #{dir}")
  end
end
