$( document ).ready(function() {
  $('.btn.btn-link.comment_like_button').click(function(e) {
    //alert(e.target.getAttribute('data-post-id'));
    var likesCount = parseInt(e.target.getAttribute('data-likes-count'), 10);
    console.log("likesCount -> " + likesCount);
    $.ajax({
      // alert('request sent');
      type: 'POST',
      url: "/comments/like",
      datatype : "application/json",
      contentType: 'application/json',
      data: e.target.getAttribute('data-comment-id')
    }).done(function(msg) {
      console.log("done: " + msg);
      likesCount += 1;
      console.log("likesCount + 1 -> " + likesCount);
      e.target.setAttribute("class", "btn btn-link comment_margin_fix")
      e.target.innerHTML = "Liked! (" + likesCount + ")";
    });
  });

  $('form#post_comment').submit(function(e) {
    var valuesToSubmit = $(this).serialize();
    console.log("valuesToSubmit -> " + valuesToSubmit);
    console.log("action -> " + $(this).attr('action'));
    e.preventDefault();
    $.ajax({
        type: 'POST',
        url: $(this).attr('action'), //sumbits it to the given url of the form
        data: valuesToSubmit,
        contentType: 'application/json',
        dataType: 'application/json' // you want a difference between normal and ajax-calls, and json is standard
    }).success(function(json){
        console.log("success", json);
    });
  });
});
