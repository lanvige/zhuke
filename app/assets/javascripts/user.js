$(document).ready(function() {
  //alert('Handler for .click() called.');
  alert(sssaaa);
});

$('#follow').click(function() {
  alert("sss");
  $.ajax({
    type: "POST",
    url: "/users/" + $("#user_slug").val() + "/follow/",
    success: function() {
      alert("Follow successed!!");
    }
  });
});

$('#unfollow').click(function() {  
  $.ajax({
    type: "POST",
    url: "/users/" + $("#user_slug").val() + "/unfollow/",
    success: function() {
      alert("Unfollow successed!!");
    }
  });
});
