jQuery(function($) {
  $('.search').bind("propertychange keyup input paste", function(event){
    if ($('.search').data('oldVal') != $('.search').val()) {
      $('.search_button').click();
    }
  });
  $('.search').each(function(){
    $(this).data('oldVal', $(this).val());
  });
  if ($('.search').val() != "") {
    $('.search_button').click();
  }
  $(".search_button").click( function() { 
    $('.search').data('oldVal',  $('.search').val());
  });
  $(".search_response").bind("ajax:success",
    function(data, xhr, response){
      $('.list').html(xhr);
    });

  $(".show_more").bind("ajax:success",
    function(data, xhr, response){
      $('.more_posts').before(xhr);

    });
});
