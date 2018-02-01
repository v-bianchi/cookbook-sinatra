//Check off specific recipes by clicking
$(".recipe-title").on("click", function(){
  $(this).toggleClass("completed");
});

//Toggling the form
$(".fa-plus").click(function(){
  $(".form").fadeToggle();
})
