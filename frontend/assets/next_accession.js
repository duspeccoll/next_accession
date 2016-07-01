$(function() {
  var $accessionForm = $("#next_accession_form");
  var $accessionResults = $("#next_accession_results");
  var $createAccession = $("#create_accession");

  $accessionForm.ajaxForm({
    dataType: "json",
    type: "GET",
    beforeSubmit: function() {
      if(!$("#next-accession-year", $accessionForm).val()) {
        return false;
      }
      $(".btn", $accessionForm).attr("disabled", "disabled").addClass("disabled").addClass("busy");
    },
    success: function(json) {
      $(".btn", $accessionForm).removeAttr("disabled").removeClass("disabled").removeClass("busy");
      $accessionResults.empty();
      $accessionResults.append(AS.renderTemplate("next_accession_id_template", {id: json["id"]}));
    }
  });
})
