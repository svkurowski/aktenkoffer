require 'will_paginate/view_helpers/action_view'

module PaginationHelper
  module BulmaRenderer
    def to_html
      pages = pagination
      page_prev = pages.delete(:previous_page)
      page_next = pages.delete(:next_page)

      content = content_for_pagination(pages, page_prev, page_next)
      tag('nav', content, class: "pagination is-centered #{@options[:class]}")
    end

    def container_attributes
      super.except(:link_options)
    end

    protected

      def page_number(page)
        return tag(:li, tag(:span, page), class: 'pagination-link is-current') if page == current_page

        link_options = @options[:link_options] || {}
        tag :li, link(page, page, link_options.merge(rel: rel_value(page), class: 'pagination-link'))
      end

      def gap
        tag :li, '<span class="pagination-ellipsis">&hellip;</span>'
      end

      def content_for_pagination(pages, page_prev, page_next)
        list_items = list_items_for(pages)

        content = tag('ul', list_items, class: 'pagination-list')
        content.prepend(next_page) if page_next
        content.prepend(previous_page) if page_prev
        content
      end

      def list_items_for(pages)
        pages.map { |item| item.is_a?(Integer) ? page_number(item) : send(item) }
             .join(@options[:link_separator])
      end

      def previous_page
        num = @collection.current_page - 1 if @collection.current_page.positive?

        previous_or_next_page(num, @options[:previous_label], 'pagination-previous')
      end

      def next_page
        num = @collection.current_page + 1 if @collection.current_page < @collection.total_pages

        previous_or_next_page(num, @options[:next_label], 'pagination-next')
      end

      def previous_or_next_page(page, text, classname)
        link_options = @options[:link_options] || {}

        return tag(:li, link(text, page, link_options), class: classname) if page

        tag :li, tag(:span, text), class: classname, disabled: true
      end
  end
end

WillPaginate::ActionView::LinkRenderer.send(:include, PaginationHelper::BulmaRenderer)
