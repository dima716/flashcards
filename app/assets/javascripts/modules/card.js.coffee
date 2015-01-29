$(document).on "change", ".btn-file :file", ->
  input = $(this)
  numFiles = (if input.get(0).files then input.get(0).files.length else 1)
  label = input.val().replace(/\\/g, "/").replace(/.*\//, "")
  $("#picture_text").val(label)
  return
