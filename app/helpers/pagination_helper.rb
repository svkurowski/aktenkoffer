require 'will_paginate/view_helpers/action_view'

module PaginationHelper
  module BulmaRenderer
    def to_html
      pages = pagination
      page_prev = pages.delete(:previous_page)
      page_next = pages.delete(:next_page)

      list_items = pages.map { |item| item.is_a?(Integer) ? page_number(item) : send(item) }
                        .join(@options[:link_separator])

      content = tag('ul', list_items, class: 'pagination-list')
      content.prepend(next_page) if page_next
      content.prepend(previous_page) if page_prev

      tag('nav', content, class: "pagination is-centered #{@options[:class]}")
    end

    def container_attributes
      super.except(*[:link_options])
    end

    protected

      def page_number(page)
        link_options = @options[:link_options] || {}

        return tag(:li, tag(:span, page), class: ('pagination-link is-current')) if page == current_page
        tag :li, link(page, page, link_options.merge(rel: rel_value(page), class: 'pagination-link'))
      end

      def previous_or_next_page(page, text, classname)
        link_options = @options[:link_options] || {}

        return tag(:li, link(text, page, link_options), class: classname) if page
        tag :li, tag(:span, text), class: classname, disabled: true
      end

      def gap
        tag :li, '<span class="pagination-ellipsis">&hellip;</span>'
      end

      def previous_page
        num = @collection.current_page > 1 && @collection.current_page - 1

        previous_or_next_page(num, @options[:previous_label], 'pagination-previous')
      end

      def next_page
        num = @collection.current_page < @collection.total_pages && @collection.current_page + 1

        previous_or_next_page(num, @options[:next_label], 'pagination-next')
      end
  end
end

WillPaginate::ActionView::LinkRenderer.send(:include, PaginationHelper::BulmaRenderer)
