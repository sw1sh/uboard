jQuery(function(e){e(".search").bind("propertychange keyup input paste",function(t){e(".search").data("oldVal")!=e(".search").val()&&e(".search_button").click()}),e(".search").each(function(){e(this).data("oldVal",e(this).val())}),e(".search").val()!=""&&e(".search_button").click(),e(".search_button").click(function(){e(".search").data("oldVal",e(".search").val())}),e(".search_response").bind("ajax:success",function(t,n,r){e(".list").html(n)}),e(".show_more").bind("ajax:success",function(t,n,r){e(".more_posts").before(n)})});