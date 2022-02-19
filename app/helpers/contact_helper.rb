module ContactHelper
  def label_for_contact(contact)
    tag.span(class: 'icon-text') do
      concat(tag.span(contact&.name || ''))
      concat(icon_for(:home)) if contact&.home?
    end
  end
end
