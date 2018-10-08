$(document).on('turbolinks:load', function () {
  $('[data-toggle-collapsed]').each(function() {
    var $el = $(this);
    $el.on('click', function (e) {
      e.preventDefault();
      var $target = $($el.data('toggle-collapsed'));
      $target.toggleClass('collapsed');
    })
  });
})
