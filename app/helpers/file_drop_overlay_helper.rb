module FileDropOverlayHelper
  def file_drop_overlay(multiple: false)
    return overlay_for_multiple if multiple

    default_overlay
  end

  private

    def overlay_for_multiple
      default_overlay(drop_hint: 'Drop one or more files to create new documents.')
    end

    def default_overlay(drop_hint: 'Drop file here to upload.')
      tag.div(class: 'file-drop-overlay has-background-black-ter is-flex is-centered') do
        tag.div(class: 'drop-message has-text-light is-flex is-centered') do
          tag.p(class: 'is-size-4 has-text-centered') do
            drop_hint
          end
        end
      end
    end
end
