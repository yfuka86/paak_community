$(function(){
  $('textarea').textareaAutoSize();

  if (location.pathname === '/current') {
    reload();
    setInterval(reload, 3000);
    $(window).resize(function() {
      setTimeout(setMasonry, 100);
    });
  }
  // loading events
  $.ajax({
    url: location.origin + '/api/events'
  }).done(function(res) {
    $('#event-board').empty()
    var div = $("<div class='panel panel-default' />");
    var calendarUrl = "https://calendar.google.com/calendar/embed?src=techlabpaak@gmail.com&ctz=Asia/Tokyo";
    div.append("<div class='panel-heading'> 直近のイベント </div>");
    if (res.events.length === 0) {
      div.append("<div class='panel-body'>No evnets to show</div>");
    } else {
      var table = $("<table class='table' />");
      res.events.forEach(function(e){
        var tr = $("<tr>");
        var start = e.start.date_time ? new Date(e.start.date_time) : new Date(e.start.date);
        var end = e.end.date_time ? new Date(e.end.date_time) : new Date(e.end.date);

        tr.append("<td>" + formatDate(start) + ' ' + formatTime(start) + '~' + formatTime(end) + "</td>");
        tr.append("<td>" + e.summary + "</td>");
        table.append(tr);
      });
      div.append(table);
    }
    div.append("<div class='panel-footer'><a href='" + calendarUrl + "'> Google Calendar</a></div>");
    $('#event-board').append(div);
  });
})

var timestamp = null;

function setMasonry () {
  var cardWidth = $(window).width() > 970 ? 228 : 170;
  $('#user-board').masonry({
    itemSelector: '.user-card',
    columnWidth: cardWidth
  });
}

function formatDate(date) {
  var format = "YYYY年MM月DD日";
  format = format.replace(/YYYY/g, date.getFullYear());
  format = format.replace(/MM/g, ('0'+(date.getMonth()+1)).slice(-2));
  format = format.replace(/DD/g, ('0'+(date.getDate()+1)).slice(-2));
  return format;
}

function formatTime(date) {
  var minutes = String(date.getMinutes()).length === 1 ? '0' + date.getMinutes() : date.getMinutes()
  return date.getHours() + ':' + minutes;
}

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
          setTimeout(setMasonry, 100);
        }
      });

      timestamp = ts;
    }
  });


}
