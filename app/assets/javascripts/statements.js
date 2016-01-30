function statements_observers() {
  $("#add_myself").off("click").on("click", function(e){
    $("#source_box").hide();
  });

  $("#add_someone_else").off("click").on("click", function(e){
    $("#source_box").show();
  });

  $(".reason_category").change(function() {
    var reason_category = $(this).find('option:selected').val();
    var agreement_id = $(this).attr("agreement_id");
    var data_form = $('form[id="edit_agreement_' + agreement_id + '"]');
    
    $.ajax({
      type : 'PUT',
      async : false,
      url : "/agreements/" + agreement_id,
      data : data_form.serialize(),
      dataType: "json",
      contentType : "application/x-www-form-urlencoded;charset=utf-8"
    })
    .fail(function(){
      alert("Error saving the category");
    });
  });
}
