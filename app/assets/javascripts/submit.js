$(document).on('turbolinks:load', function () {
  $('[data-submit]').each(function () {
    var $link = $(this)
    $link.on('click', function (e) {
      e.preventDefault()
      $($link.data('submit')).submit();
    })
  })
})
