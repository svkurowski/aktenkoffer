class APIKey < ApplicationRecord
  SECRET_LENGTH = 40

  has_secure_password :secret, validations: false

  validates :description, presence: true

  validate do |record|
    record.errors.add(:secret, :blank) unless record.secret_digest.present?
  end

  validates :secret, length: { is: SECRET_LENGTH }, allow_blank: true
end
