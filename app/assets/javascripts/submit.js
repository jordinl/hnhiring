$(document).on('turbolinks:load', function () {
  $('[data-submit]').each(function () {
    var $link = $(this)
    $link.on('click', function (e) {
      e.preventDefault()
      var $form = $($link.data('submit'))
      var url = $form.attr('action')
      var query = $form.serializeArray().filter(function (input) {
        return input.value
      }).map(function(input) {
        return input.name + '=' + input.value
      }).join('&').replace(/\s+/g, '+')
      if (query) {
        url += '?' + query
      }
      Turbolinks.visit(url)
    })
  })
})
