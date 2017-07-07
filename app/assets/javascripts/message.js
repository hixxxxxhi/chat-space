$(function() {
  function buildHtml(message) {
    var imageHtml = message.image_url ? `<img src="${message.image_url}">` : "";
    var html = `<div class="chat-message">
                  <div class="chat-message__user-name">
                    ${message.user_name}
                    <span class="chat-message__date-time">
                      ${message.created_at}
                    </span>
                  </div>
                  <div class="chat-message__message">
                    <p>${message.body}</p>
                    ${imageHtml}
                  </div>
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
});
