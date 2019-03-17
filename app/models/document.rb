class Document < ApplicationRecord
  ACTED_AT_SQL = "COALESCE(received_at, sent_at, #{table_name}.created_at::date)".freeze
  private_constant :ACTED_AT_SQL

  belongs_to :sender, class_name: 'Contact', optional: true
  belongs_to :recipient, class_name: 'Contact', optional: true

  validate :original_file_cannot_be_blank

  has_one_attached :original_file

  def acted_at
    received_at || sent_at || created_at.to_date
  end

  def original_file_cannot_be_blank
    errors.add(:original_file, :blank) unless original_file.attached?
  end

  def self.acted_at_after(date_string)
    date = Date.parse(date_string)
    where("#{ACTED_AT_SQL} >= ?", date)
  end

  def self.acted_at_before(date_string)
    date = Date.parse(date_string)
    where("#{ACTED_AT_SQL} <= ?", date)
  end

  def self.with_title(title)
    where('title ILIKE ?', "%#{title}%")
  end

  def self.with_sender(name)
    joins('LEFT OUTER JOIN contacts AS sender ON documents.sender_id = sender.id')
      .where('sender.name ILIKE ?', "%#{name}%")
  end

  def self.with_recipient(name)
    joins('LEFT OUTER JOIN contacts AS recipient ON documents.recipient_id = recipient.id')
      .where('recipient.name ILIKE ?', "%#{name}%")
  end

  def self.order_by_acted_at(dir = 'DESC')
    direction = ['ASC', 'DESC'].include?(dir) ? dir : 'DESC'
    order_sql = <<-SQL
      #{ACTED_AT_SQL} #{direction},
      #{table_name}.created_at #{direction},
      #{table_name}.id #{direction}
    SQL
    order(Arel.sql(order_sql))
  end
end
