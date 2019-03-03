class Document < ApplicationRecord
  belongs_to :sender, class_name: 'Contact', optional: true
  belongs_to :recipient, class_name: 'Contact', optional: true

  has_one_attached :original_file

  def acted_at
    received_at || sent_at || created_at.to_date
  end

  def self.with_title(title)
    where('title ILIKE ?', "%#{title}%") if title.present?
  end

  def self.with_sender(name)
    return unless name.present?

    joins('LEFT OUTER JOIN contacts AS sender ON documents.sender_id = sender.id')
      .where('sender.name ILIKE ?', "%#{name}%")
  end

  def self.with_recipient(name)
    return unless name.present?

    joins('LEFT OUTER JOIN contacts AS recipient ON documents.recipient_id = recipient.id')
      .where('recipient.name ILIKE ?', "%#{name}%")
  end

  def self.order_by_acted_at(dir = 'DESC')
    direction = ['ASC', 'DESC'].include?(dir) ? dir : 'DESC'
    order("COALESCE(received_at, sent_at, #{self.table_name}.created_at::date) #{direction}")
  end
end
