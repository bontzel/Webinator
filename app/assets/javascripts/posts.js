$( document ).ready(function() {
  $('.btn.btn-link.post_like_button').click(function(e) {
    //alert(e.target.getAttribute('data-post-id'));
    var likesCount = parseInt(e.target.getAttribute('data-likes-count'), 10);
    $.ajax({
      // alert('request sent');
      type: 'POST',
      url: "/posts/like",
      datatype : "application/json",
      contentType: 'application/json',
      data: e.target.getAttribute('data-post-id')
    }).done(function(msg) {
      console.log("done: " + msg);
      likesCount += 1;
      e.target.setAttribute("class", "btn btn-link")
      e.target.innerHTML = "Liked! (" + likesCount + ")";
    });
  });
});
