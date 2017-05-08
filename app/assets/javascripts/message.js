$(document).on('turbolinks:load', function() {
  function buildMessage(message) {
    var html =  `<li class='chat-message' id='${message.id}'>
                  <div class='chat-message__header'>
                    <p class='chat-message__name'> ${ message.user_name } </p>
                    <p class='chat-message__time'> ${ message.created_at } </p>
                  </div>`
    if (message.content === undefined) {
      html += `<p class="chat-message__body"> <img src='${ message.image }'> </p></li>`
    } else if (message.image === undefined) {
      html += `<p class="chat-message__body"> ${ message.content } </p></li>`
    } else {
      html += `<p class="chat-message__body"> ${ message.content } <br> <img src='${ message.image }'> </p></li>`
    }
    $('.chat-messages').append(html);
    $('.chat-messages').animate({ scrollTop: ($('.chat-messages')[0].scrollHeight)}, 1000 * 1);
  }

  $('#new_message').on('submit', function(e) {
    e.preventDefault();
    var textField = $('#message_content');
    var message   = textField.val();
    var formdata  = new FormData($('#new_message').get(0));
    // 一回送信すると送信ボタンにdata-disable-withがつくのでそれを削除して連続投稿を可能にする
    $('#chat-footer__btn').removeAttr('data-disable-with');
    $.ajax({
      type:        'POST',
      data:        formdata,
      // これは次に動かしたいコントローラーのパス
      url:         '/messages',
      dataType:    'json',
      // FormData使ってとってくると、下2つが必要。ajaxが勝手にとってくるやつとエラーを起こす
      processData: false,
      contentType: false
      // ここまで読まれたらコントローラーが動く
    })
    .done(function(data) {
      // ここのdataにformat.jsonで指定したインスタンスが入る
      buildMessage(data);
      textField.val('');
    })
    .fail(function() {
      alert('error');
    });
  });

  $('form').on('change', 'input[type="file"]', function(e) {
    e.preventDefault();
    var formdata  = new FormData($('#new_message').get(0));
    $.ajax({
      type:        'POST',
      data:        formdata,
      url:         '/messages',
      dataType:    'json',
      processData: false,
      contentType: false
    })
    .done(function(data) {
      buildMessage(data);
      $('input[type="file"]').val('');
    })
    .fail(function() {
      alert('error');
    });
  });

  // 自動更新のための関数
  var autoLoad = function() {
    var url = location.href;
    // 今のURLがメッセージ一覧のURLかを確かめる。違ったらタイマーを止める
    if (url.match(/groups\/\d/)) {
      $.ajax({
        type:     'GET',
        data:     {
                  message_id: $('li:last').attr('id'),
                  group_id:   $('#message_group_id').attr('value'),
                  },
        url:      '/messages/reload',
        dataType: 'json'
      })
      .done(function(messages) {
        messages.forEach(function(message) {
          buildMessage(message);
        });
      })
      .fail(function() {
        console.log('error');
      });
    } else {
      clearInterval(timer);
    }
  }
  var timer = setInterval(autoLoad, 1000 * 5);
});
