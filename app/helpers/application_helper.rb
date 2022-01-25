module ApplicationHelper
  def home_contact
    home_contact_id = Aktenkoffer::Application.config.home_contact_id
    if home_contact_id.nil?
      nil
    else
      Contact.find(Aktenkoffer::Application.config.home_contact_id)
    end
  end
end
