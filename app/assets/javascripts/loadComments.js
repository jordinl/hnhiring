$(document).ready(function () {
  $('[data-load-comment]').each(function() {
    var $comment = $(this);
    setTimeout(function () { $comment.removeClass('hidden')}, 20)
  })
})
