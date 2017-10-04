json.extract! conversation, :id, :recipient_id, :sender_id, :created_at, :updated_at
json.url conversation_url(conversation, format: :json)
