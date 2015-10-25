$(document).ready(function(){
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
            res.users.forEach(function(u){
              $div = $("<div class='user-card'></div>");
              $image = $("<img class='user-image' src='" + u.image_url + "'/>");
              $name = $("<p class='user-name'>" + u.name + "</p>");
              $url = $("<a href='" + u.facebook_url + "?width=200&height=200'><span class='fa fa-facebook' /></a>");
              $period = $("<p class='user-period'>" + u.latest_period + "</p>");
              $('#user-board').append($div, [$image, $name, $url, $period]);
            })
          });

          timestamp = ts;
        }
      });
    }, 5000);
  }
})