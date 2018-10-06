$(document).on('turbolinks:load', function () {
  $('[data-submit]').each(function() {
    var $link = $(this)
    $link.on('click', function (e) {
      e.preventDefault();
      var $form = $($link.data('submit'));
      var url = $form.attr('action');
      var query = $form.serialize()
      if (query) {
        url += '?' + query
      }
      Turbolinks.visit(url);
    });
  });
})
