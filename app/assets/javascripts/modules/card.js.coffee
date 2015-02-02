$(document).on "change", ".btn-file :file", ->
  input = $(this)
  label = input.val().replace(/\\/g, "/").replace(/.*\//, "")
  $("#picture_text").val(label)
  return
