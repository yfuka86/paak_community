$(function(){
  $('textarea').textareaAutoSize();

  if (location.pathname === '/current') {
    reload();
    setInterval(reload, 3000);
  }
})

var timestamp = null;

function reload () {
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
        } else {
          res.users.forEach(function(u){
            $link = $("<a class='user-card' href='" + location.origin + '/users/' + u.id + "'></a>");
            $image = $("<img class='user-image' src='" + u.image_url + "?width=300&height=300'/>");
            $period = $("<p class='user-period'>#" + u.latest_period + "</p>");
            $name = $("<p class='user-name'>" + u.name + "</p>");
            $facebook = $("<p><a href='" + u.facebook_url + "'><span class='fa fa-facebook' /></a></p>")
            $link.append([$image, $period, $name, $facebook]);
            $('#user-board').append($link);
          })
          var cardWidth = $(window).width() > 970 ? 228 : 180;
          $('#user-board').masonry({
            itemSelector: '.user-card',
            columnWidth: cardWidth
          });
        }
      });

      timestamp = ts;
    }
  });
}