$(function() {
  function buildHTML(message) {
    var html = $('<li class="chat-message">').append(`<p class="chat-message__name"> ${message.user_name} </p><p class="chat-message__time"> ${message.created_at} </p><p class="chat-message__body"> ${message.content} </p>`);
    return html;
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
      url:         '/messages',
      dataType:    'json',
      // FormData使ってとってくると、下2つが必要。ajaxが勝手にとってくるやつとエラーを起こす
      processData: false,
      contentType: false
      // ここまで読まれたらコントローラーが動く
    })
    .done(function(data) {
      // ここのdataにformat.jsonで指定したインスタンスが入る
      var html = buildHTML(data);
      $('.chat-messages').append(html);
      textField.val('');
    })
    .fail(function() {
      alert('error');
    });
  });
});
