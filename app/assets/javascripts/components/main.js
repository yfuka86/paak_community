$(function(){
  $('textarea').textareaAutoSize();

  if (location.pathname === '/current') {
    var timestamp = null;
    setInterval(function(){
      $.ajax({
        url: location.origin + '/api/records/latest_ts'
      }).done(function(res) {
        ts = res.ts;
        if (!timestamp || timestamp < ts) {
          $.ajax({
            url: location.origin + '/api/users'
          }).done(function(res) {
            $('#user-board').empty()
            if (res.users.length === 0) {
              $div = $("<div class='no-user'>No members to show</div>");
              $('#user-board').append($div);
            }
            res.users.forEach(function(u){
              $div = $("<a class='user-card' href='" + location.origin + '/users/' + u.id + "'></a>");
              $image = $("<img class='user-image' src='" + u.image_url + "?width=200&height=200'/>");
              $period = $("<p class='user-period'>#" + u.latest_period + "</p>");
              $name = $("<p class='user-name'>" + u.name + "<a href='" + u.facebook_url + "'><span class='fa fa-facebook' /></a></p>");
              $div.append([$image, $period, $name]);
              $('#user-board').append($div);
            })
          });

          timestamp = ts;
        }
      });
    }, 5000);
  }
})