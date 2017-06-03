module ApplicationHelper
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
