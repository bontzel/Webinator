// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$( document ).ready(function() {
  var data = JSON.stringify($('#requests-widget').data('requests'))
  if (data !== '[]') {
    $('#requests-widget').click(function() {
      $.ajax({
        // alert('request sent');
        type: 'PATCH',
        url: "/friendships/read_requests",
        datatype : "application/json",
        contentType: 'application/json',
        data: data
      }).done(function(msg) {
        $('#requests-badge' ).addClass( "hidden" );
      });
    });
  }
});
