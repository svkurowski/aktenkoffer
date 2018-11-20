json.extract! contact, :id, :name, :address, :created_at, :updated_at
json.url contact_url(contact, format: :json)
