$(document).ready(function() {

  $("#add_myself").off("click").on("click", function(e){
    $("#source_box").hide();
  });

  $("#add_someone_else").off("click").on("click", function(e){
    $("#source_box").show();
  });

}
