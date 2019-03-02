class DocumentSearch
  ATTRIBUTES = ['title']

  # Since senders is the second join on contacts, ActiveRecord will rename it to senders_documents
  ASSOCIATIONS = [
    { name: 'recipient',  attribute: 'name', table: 'contacts' },
    { name: 'sender',     attribute: 'name', table: 'senders_documents' }
  ]

  def self.perform(query)
    new(query).send(:perform)
  end

  def initialize(query)
    @documents = Document.all
    @params = extract_search_params_from(query)
  end

  private

    def extract_search_params_from(query)
      return {} unless query.present?

      query
        .split(' ')
        .map { |param| param.split(':') }
        .map { |(key, value)| { key => value } }
        .inject(:merge)
    end

    def perform
      return @documents unless @params.any?

      filter_defaults
      filter_attributes
      filter_associations

      @documents
    end

    def filter_defaults
      @params.filter { |_, v| v.nil? }.keys.each do |value|
        @documents = @documents.where('title ILIKE ?', "%#{value}%")
      end
    end

    def filter_attributes
      ATTRIBUTES.each do |attribute|
        @documents = @documents.where("#{attribute} ILIKE ?", "%#{@params[attribute]}%") if @params[attribute].present?
      end
    end

    def filter_associations
      ASSOCIATIONS.each do |association|
        next unless @params[association[:name]].present?

        @documents = @documents.joins(association[:name].to_sym)
        @documents =
          @documents.where(
            "#{association[:table]}.#{association[:attribute]} ILIKE ?",
            "%#{@params[association[:name]]}%"
          )
      end
    end
end
