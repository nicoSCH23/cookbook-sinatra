$(document).ready(function(){

  $(".right").click(function(){
    location.reload()
  });

  $(".wrong").click(function(){
    $(this).removeClass('btn-outline-info').addClass('btn-danger');
  });

});
