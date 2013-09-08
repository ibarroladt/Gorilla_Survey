function disp_confirm() {
	var r=confirm("Are you sure you want to delete?  Press OK to continue")
	if (r==true) {
	  return true
	}
	else {
		return false
	}
}

$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
  $('.delete').click(function(event) {
  	event.preventDefault();
  	var del = disp_confirm();
  	if (del == true) {
  		$.post($(this).attr("href"), function(response) {
			$('.container').html(response);
			});
  	}
  });

  $('.survey-delete').click(function(event) {
  	event.preventDefault();
  	var del = disp_confirm();
  	if (del == true) {
  		$.post($(this).attr("href"), function(response) {
				window.location.replace(response.redirect)
			}, "json");
  	}
  });
});
