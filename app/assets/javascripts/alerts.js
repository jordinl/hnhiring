$(document).on('turbolinks:load', function () {
  $('[data-alert]').each(function () {
    $(this).fadeOut(6000)
  })
})
