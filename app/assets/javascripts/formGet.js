$(document).on('turbolinks:load', function () {
  $('[data-form-get]').each(function () {
    var $form = $(this)
    $form.on('submit', function (e) {
      e.preventDefault()
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
