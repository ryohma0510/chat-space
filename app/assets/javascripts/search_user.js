$(function() {
  //削除ボタンが押された時のやつ
  $(document).on('click', '.chat-group-form__member__btn--remove',function(e) {
    e.preventDefault();
    $(this).parent("div").remove();
  });

  //追加ボタンが押された時のやつ
  $(document).on('click', '.chat-group-form__member__btn--add', function(e) {
    e.preventDefault();
    var user = { name: $(this).parent().find('p').html(), id: $(this).parent().find('input').attr('value') }
    var delete_btn = buildRemoveButton(user);
    $('#registered').append(delete_btn);
    $(this).parent("div").remove();
  });

  //削除ボタンのHTMLを作る
  function buildRemoveButton(user) {
    var html = `<p class='chat-group-form__member__name chat-group-form__member__${user.id}'> ${user.name} </p>
                <a href='#' class='chat-group-form__member__btn--remove'> 削除 </a>
                <input type='hidden' name='group[user_ids][]' value='${user.id}'></input>`;
    return $('<div class="chat-group-form__member clear-fix">').append(html);
  }

  //追加ボタンのHTMLを作る
  function buildAddButton(user) {
    var html = `<p class='chat-group-form__member__name'> ${user.name} </p>
                <a href='#' class='chat-group-form__member__btn--add'>追加</a>
                <input type='hidden' name='delete_user_ids' value='${user.id}'></input>`;
    return $('<div class="chat-group-form__member clear-fix">').append(html);
  }

  //インクリメンタルサーチする
  $('#user-search-field').on('keyup', function(e) {
    $('#user-search-result').children().remove();
    input = $('#user-search-field').val();
    $.ajax({
      type:        'GET',
      data:        { keyword:  input },
      url:         '/users/search',
      dataType:    'json',
    })
    .done(function(data) {
      for(var i = 0; i < data.length; i++) {
        var add_btn = buildAddButton(data[i]);
        $('#user-search-result').append(add_btn);
      }
      $('#user-search-field').val();
    })
    .fail(function() {
      alert('error');
    });
  });
});
