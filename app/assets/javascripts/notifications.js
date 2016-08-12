// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
$( document ).ready(function() {
  var data = JSON.stringify($('#notifications-widget').data('notifications'))
  var arr = new Array();
  $('#notifications-widget').data('notifications').forEach(function (item){
    arr.push(item);
  });
  var json = new Object();
  json.notifications = arr;
  var data = JSON.stringify(json)

  if(arr.length > 0) {
    $('#notifications-widget').click(function() {
      $.ajax({
        // alert('request sent');
        type: "PATCH",
        url: "/notifications/read_notifications",
        datatype : "applicaton/json",
        contentType: 'application/json',
        data: data,
        success: function(msg) {
          $('#notifications-badge' ).addClass( "hidden" );
        }.bind(this),
        error: function (xhr, status, err) {
          console.error(status, err.toString());
        }.bind(this)
      });
    });
  }

});
