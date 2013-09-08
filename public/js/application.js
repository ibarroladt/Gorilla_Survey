function disp_confirm() {
	var r=confirm("Are you sure you want to delete?  Press OK to continue")
	if (r==true) {
	  return true
	}
	else {
		return false
	}
}

function confirm_delete_item(aTag) {
	$( "#dialog-confirm" ).dialog({
      resizable: false,
      height: 250,
      width: 400,
      modal: true,
      buttons: {
        "Delete": function() {
        	$.post(aTag.attr("href"), function(response) {
						$('.container').html(response);
						onLoad();
					});
          $( this ).dialog( "close" );
        },
        Cancel: function() {
          $( this ).dialog( "close" );
          return true;
        }
      }
    });
}

function confirm_delete_survey(aTag) {
	$( "#dialog-confirm" ).dialog({
      resizable: false,
      height: 250,
      width: 400,
      modal: true,
      buttons: {
        "Delete": function() {
        	$.post(aTag.attr("href"), function(response) {
						window.location.replace(response.redirect)
					}, "json");
          $( this ).dialog( "close" );
        },
        Cancel: function() {
          $( this ).dialog( "close" );
          return true;
        }
      }
    });
}

function onLoad() {
	$('#dialog-confirm').hide();

  $('.delete').click(function(event) {
  	event.preventDefault();
  	confirm_delete_item($(this));
  });

  $('.survey-delete').click(function(event) {
  	event.preventDefault();
  	confirm_delete_survey($(this));
  });
}

$(document).ready(onLoad); 
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
  

