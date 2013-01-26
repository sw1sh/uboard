jQuery(function($) {
  
  searchBindings();
  tagsBindings();
  
  if ($('#seach_field').val() != "") {
    $('#search_button').click();
  }
  
  $("#show_more").bind("ajax:success",
    function(data, xhr, response){
      $('#search_button').click();
    });
  
  $("a[rel^='prettyPhoto']").prettyPhoto({social_tools: false, theme: 'light_square'});
  
});

function searchBindings()
{
  var input = $('#search_field');
  var button = $('#search_form #search_button');
  button.click( function() { 
    input.data('oldVal',  input.val());
  });
 
  input.bind("propertychange keyup input paste", function(event){  
    if (input.data('oldVal') != input.val()) {
      button.click();
    }
  });
  input.each(function(){
    input.data('oldVal', $(this).val());
  });
  
  
  $("#search_form").bind("ajax:success",
    function(data, xhr, response){
      $('#list').html(xhr+'<div id=more_posts></div>');
    });

  
  
  
}

function tagsBindings()
{
  $("#tags a").bind("ajax:success",
    function(data, xhr, response){
      $('#tags').html(xhr);
      $('#search_button').click();
      tagsBindings();
    });
}