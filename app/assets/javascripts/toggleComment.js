$(document).on('turbolinks:load', function () {
  $('[data-toggle-collapsed]').each(function() {
    var $el = $(this)
    var $target = $el.parents($el.data('toggle-collapsed'));
    $el.text($target.attr('class').indexOf('collapsed') > -1 ? 'Show More' : 'Show Less');
    $el.on('click', function (e) {
      e.preventDefault();
      $target.toggleClass('collapsed');
      $el.text($target.attr('class').indexOf('collapsed') > -1 ? 'Show More' : 'Show Less');
    })
  });
})
