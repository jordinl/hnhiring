$(document).ready(function () {
  $('[data-submit]').each(function() {
    var $link = $(this)
    $link.on('click', function (e) {
      e.preventDefault();
      var target = $link.data('submit');
      $(target).submit();
    });
  });
})
