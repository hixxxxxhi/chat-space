json.array! @messages do |message|
  json.id         message.id
  json.user_name  message.user.name
  json.created_at message.created_at.to_time.strftime('%Y/%m/%d %H:%M:%S')
  json.body       message.body
  json.image_url  message.image.url
end
