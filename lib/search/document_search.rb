module Search
  class DocumentSearch
    def self.perform(query)
      new(query).send(:perform)
    end

    def initialize(query)
      @query = query
    end

    private

      def perform
        documents = Document.all

        params, title_queries = extract_search_params_from(@query)
        return documents unless params.any? || (title_queries.present? && title_queries.any?)

        documents = filter_attributes(documents, title_queries)
        documents = filter_attributes(documents, params)

        documents
      end

      def extract_search_params_from(query)
        return {} unless query.present?

        query
          .split(' ')
          .map { |param| param.split(':') }
          .map { |(key, value)| { key => value } }
          .reduce(&:merge)
          .partition { |(_, value)| value.present? }
          .map(&:to_h)
      end

      def filter_attributes(documents, params)
        params.keys.inject(documents.clone) do |result, attribute|
          query_method, filter_value = filter_query_for(params, attribute)
          result = result.send(query_method, filter_value) if Document.respond_to?(query_method)
          result
        end
      end

      def filter_query_for(params, attribute)
        return ["with_#{attribute}", params[attribute]] if params[attribute].present?

        ['with_title', attribute]
      end
  end
end
