json.extract! document, :id, :title, :sender_id, :recipient_id, :sent_at, :received_at, :created_at, :updated_at
json.url document_url(document, format: :json)
