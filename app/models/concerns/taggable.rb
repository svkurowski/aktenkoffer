module Taggable
  extend ActiveSupport::Concern

  included do |klass|
    Gutentag::ActiveRecord.call klass
  end
end
