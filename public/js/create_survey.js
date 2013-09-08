$(document).ready(function(){
  $("#create-question").submit(function(event){
    event.preventDefault();
    var url = $(this).attr('action');
    var data = $(this).serialize();
    $.post(url,data,function(response){
      $("#question-list").remove();
      $("#question_form").append(response);
      $(".question-field").val("");
      $("#create-question").hide();
    });
  });

  $("#create-survey").on("submit", "form#create-choice", function(event){
    event.preventDefault();
    var url = $(this).attr('action');
    var data = $(this).serialize();
    $.post(url, data, function(response){
      $("#create-choice").prev().append(response);
      $(".choice-field").val("");
    });
  });

  $("#create-survey").on("submit", "form#finish-question", function(event){
    event.preventDefault();
    $("#create-choice").remove();
    $(this).remove();
    $("#create-question").show();
    $("#create-question").insertBefore('.survey-submit');

  });
    
});
