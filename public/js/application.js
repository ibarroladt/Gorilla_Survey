function disp_confirm(aTag) {
	var r=confirm("Are you sure you want to delete?  Press OK to continue")
	if (r==true) {
		$.get(aTag.attr("href"), function(response) {
			$('.container').html(response);
		});
	}
}

$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
  $('.delete').click(function(event) {
  	event.preventDefault();
  	disp_confirm($(this));
  });
});
