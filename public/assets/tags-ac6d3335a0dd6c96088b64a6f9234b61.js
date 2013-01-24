jQuery(function($) {
  $(".tag_response").bind("ajax:success",
    function(data, xhr, response){
      $('.tags').html(xhr);
      $('.search_button').click();
    });
});
