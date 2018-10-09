$(document).on('turbolinks:load', function () {
  $('[data-show-all]').on('click', function (e) {
    var targetClass = $(this).data('show-all');
    var $elements = $(targetClass);
    e.preventDefault();
    Turbolinks.controller.adapter.progressBar.setValue(0);
    Turbolinks.controller.adapter.progressBar.show();
    $(this).parent().hide();
    $elements.each(function (index) {
      var $el = $(this);
      setTimeout(function () {
        Turbolinks.controller.adapter.progressBar.setValue((index + 1) / $elements.length)
        $el.removeClass('hidden')
        if (index == $elements.length - 1) {
          Turbolinks.controller.adapter.progressBar.hide()
        }
      }, 20)
    });
  })
})
