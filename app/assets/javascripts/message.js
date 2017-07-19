$(function() {
  // メッセージ送信の非同期化
  function buildHtml(message) {
    var html = `<div class="chat-message">
                  <div class="chat-message__user-name">
                    ${message.user_name}
                    <span class="chat-message__date-time">
                      ${message.created_at}
                    </span>
                  </div>
                  <div class="chat-message__message">
                    <p>${message.body}</p>
                    `
    if (message.image_url) {
      html = html + `<img src="${message.image_url}">`;
    }

    html = html + `</div>
                </div>`;

    return html;
  }

  $('#new_message').on('submit', function(e) {
    e.preventDefault();

    var formData = new FormData(this);
    var url = $(this).attr('action');

    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data) {
      var html = buildHtml(data);
      $('.chat-content__message-list').append(html);
      $('.chat-input__input-field').val('');
      $(".chat-input__choose-image-btn[type='file']").val('');

      $('.chat-content').delay(100).animate({
        scrollTop: $('.chat-content__message-list').height()
      }, 1500);
    })
    .fail(function() {
      alert("Failed to send a message")
    })
    .always(function() {
      $(".chat-input__send-btn").attr('disabled', false);
    });
  });

  // メッセージの自動更新処理
  var current_path = location.pathname;  // 現在のページのパス
  var message_list = $(".chat-content__message-list");

  function appendMessage(message) {
    var html = `<div class="chat-message">
                  <div class="chat-message__user-name">
                    ${message.user_name}
                    <span class="chat-message__date-time">${message.created_at}</span>
                  </div>
                  <div class="chat-message__message">`;

    if (message.body) {
      html = html + `<p>${message.body}</p>`;
    }

    if (message.image_url) {
      html = html + `<img src="${message.image_url}">`;
    }

    html = html + `</div>
                </div>`;

    message_list.append(html);
  }

  var autoUpdateMessages = function() {
    $.ajax({
      url: current_path,
      type: "GET",
      data: { },
      dataType: 'json',
    })
    .done(function(messages) {
      if (messages !== 0) {
        // いったんすべてのメッセージを削除する
        message_list.empty();

        // すべてのメッセージを表示する
        messages.forEach(function(message) {
          appendMessage(message);
        });
      }
    })
    .fail(function() {
      alert("Failed to auto-update the message list")
    });
  }

  // 現在のページがメッセージリストを表示するページである場合のみ、メッセージの自動更新を行う
  if (current_path.match(/\/groups\/\d+\/messages/i)) {
    setInterval(autoUpdateMessages, 5000);
  }
});
