$( document ).ready(function() {
  $('.btn.btn-link.post_like_button').click(function(e) {
    //alert(e.target.getAttribute('data-post-id'));
    $.ajax({
      // alert('request sent');
      type: 'POST',
      url: "/posts/like",
      datatype : "application/json",
      contentType: 'application/json',
      data: e.target.getAttribute('data-post-id')
    }).done(function(msg) {
      console.log("done: " + msg);
    });
  });
});
