$(document).on('turbolinks:load', function () {
  $('[data-checkbox-change]').on('change', function (e) {
    var value = $('[name="' + this.name + '"]:checked').map(function() { return this.value }).get().join();
    var target = $(this).data('checkbox-change');
    $(target).val(value);
  })
})
