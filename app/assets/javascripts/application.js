// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .

$(document).ready(function() {

  $("#skip").off("click").on("click", function(e){
    current_statement = statements_to_vote[0]
    statements_to_vote.splice(0, 1);
    statements_to_vote.push(current_statement);
    $("#statement").text(statements_to_vote[0][1]);
  });

  $("#quick_agree").off("click").on("click", function(e){
    addSupporter("agreement");
  });

  $("#quick_disagree").off("click").on("click", function(e){
    addSupporter("disagreement");
  });

  $("#quote").off("click").on("click", function(e){
    $("#quote_fields").removeClass("hidden")
    $("#quote_link").hide();
    e.stopPropagation();
    e.preventDefault();
  });
});

function addSupporter(agreement_or_disagreement) {
    current_statement = statements_to_vote[0][0];
    prependStatement(statements_to_vote[0], agreement_or_disagreement);
    statements_to_vote.splice(0, 1);
    if(statements_to_vote.length == 0){
      $("#quick_questions").hide();
      $("#new_statement").removeClass("hide");
    }else{
      $("#statement").text(statements_to_vote[0][1]);
    }
    if(statements_to_vote.length == 1){
      $("#quick_skip").hide();
    }
    $.ajax({
      type: 'post',
      url: "/add_supporter",
      dataType: "application/x-www-form-urlencoded;charset=utf-8",
      data: {
        add: agreement_or_disagreement,
        statement_id: current_statement
      },
      success: function(request){
      },
      error: function(data){
      }
    });
}

function prependStatement(statement, agreement_or_disagreement){
  var url = statement[2];
  var agree, disagree;
  if(agreement_or_disagreement == "agreement"){
    agree = statement[3] + 1;
    disagree = statement[4];
  }else{
    agree = statement[3];
    disagree = statement[4] + 1;
  }
  var total = agree + disagree;
  var percentage = Math.round(agree * 100 / total);
  $('#voted_questions').prepend("<br>" + "<a href=\"" + url + "\">" + statement[1] + "</a> " + percentage.toString() + "% agree");

}
