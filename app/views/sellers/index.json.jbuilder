json.array!(@sellers) do |seller|
  json.extract! seller, :id, :user_id, :tag_name, :card_no, :phone
  json.url seller_url(seller, format: :json)
end
