$(function() {
  var searchResult = $("#user-search-result");
  var chatMemberList = $("#chat-group-users");

  function appendCandidate(user) {
    var html = `<div class="chat-group-user clearfix">
                  <p class="chat-group-user__name">${user.name}</p>
                  <a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${user.id}" data-user-name="${user.name}">追加</a>
                  </div>
                </p>`;

    searchResult.append(html);
  }

  function appendChatMember(userId, userName) {
    var html = `<div class='chat-group-user clearfix js-chat-member' id='chat-group-user-8'>
                  <input name='group[user_ids][]' type='hidden' value='${userId}'>
                  <p class='chat-group-user__name'>${userName}</p>
                  <a class='user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn'>削除</a>
              </div>`;

    chatMemberList.append(html);

  }

  // インクリメンタルサーチ処理
  $(".chat-group-form__input").on("keyup", function() {
    var input = $("#user-search-field").val();

    $.ajax({
      type: 'GET',
      url: '/users/search',
      data: { keyword: input },
      dataType: 'json'
    })
    .done(function(users) {
      $("#user-search-result").empty();
      if (users.length !== 0 && input !== "") {
        users.forEach(function(user) {
          appendCandidate(user);
        });
      }
    })
    .fail(function() {
      alert('ユーザー検索に失敗しました');
    });
  });

  // 「追加」ボタンが押されたときの処理
  $("#user-search-result").on("click", ".chat-group-user__btn--add", function() {
    userId = $(this).attr("data-user-id");
    userName = $(this).attr("data-user-name");

    // 「追加」ボタンが押された項目を検索結果から削除する
    $(this).parent().remove();

    // 「追加」ボタンが押された項目を「チャットメンバー」欄に追加する
    appendChatMember(userId, userName);
  });

  // 「削除」ボタンが押されたときの処理
  $("#chat-group-users").on("click", ".chat-group-user__btn--remove", function() {
    console.log(this);
    // 「削除」ボタンが押された項目を削除する
    $(this).parent().remove();
  });
});
