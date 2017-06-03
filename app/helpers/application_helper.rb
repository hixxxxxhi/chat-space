module ApplicationHelper
  def divide_by_comma(users)
    usernames = []
    users.each do |u|
      usernames << u.name
    end
    usernames.join(", ")
  end

  def display_latest_message_or_status_message(group)
    if group.messages.any?
      if group.messages.last.body.empty?
        "画像が投稿されています。"
      else
        group.messages.last.body
      end
    else
      "まだメッセージはありません。"
    end
  end
end
