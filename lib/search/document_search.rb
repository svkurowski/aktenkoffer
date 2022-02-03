module Search
  class DocumentSearch
    OPERATOR_TO_METHOD_SYMBOL = {
      after: :acted_at_after,
      before: :acted_at_before,
      from: :with_sender,
      tag: :with_tag,
      title: :with_title,
      to: :with_recipient
    }.freeze
    private_constant :OPERATOR_TO_METHOD_SYMBOL

    class << self
      def perform(query)
        documents = Document.all

        params, title_queries = extract_search_params_from(query)
        return documents unless params.any? || (title_queries.present? && title_queries.any?)

        documents = filter_attributes(documents, title_queries)

        filter_attributes(documents, params)
      end

      private

        def extract_search_params_from(query)
          return {} unless query.present?

          query
            .split
            .map { |param| param.split(':') }
            .map { |(key, value)| { key => value } }
            .reduce(&:merge)
            .partition { |(_, value)| value.present? }
            .map(&:to_h)
        end

        def filter_attributes(documents, params)
          params.keys.reduce(documents) do |result, attribute|
            query_method, filter_value = filter_query_for(params, attribute)
            result = result.send(query_method, filter_value)
            result
          end
        end

        def filter_query_for(params, attribute)
          attribute_value = params[attribute]
          method_symbol = OPERATOR_TO_METHOD_SYMBOL[attribute.to_sym]
          if attribute_value.present? && method_symbol.present?
            [method_symbol, attribute_value]
          else
            [:with_title, attribute]
          end
        end
    end
  end
end
