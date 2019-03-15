module IconHelper
  ICON_CLASSES = {
    briefcase: 'briefcase',
    edit: 'pencil-alt',
    delete: 'trash-alt'
  }

  SIZE_CLASSES = {
    small: ' is-small',
    normal: '',
    medium: ' is-medium',
    large: ' is-large'
  }

  def icon_for(icon, options = {})
    icon_class = ICON_CLASSES[icon]
    raise 'Icon not found' unless icon_class.present?

    icon_wrapper_with(icon_element_for(icon_class), size: options[:size])
  end

  private

    def icon_wrapper_with(icon, size: :normal)
      content_tag(:span, icon, class: "icon#{SIZE_CLASSES[size]}")
    end

    def icon_element_for(icon_class)
      content_tag(:i, '', class: ['fas', "fa-#{icon_class}"])
    end
end
