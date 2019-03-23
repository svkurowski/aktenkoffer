module FileDropOverlayHelper
  def file_drop_overlay
    content_tag(:div, class: 'file-drop-overlay has-background-black-ter is-flex is-centered') do
      content_tag(:div, class: 'drop-message has-text-light is-flex is-centered') do
        content_tag(:p, class: 'is-size-4 has-text-centered') do
          'Drop file here to upload.'
        end
      end
    end
  end
end
