$(document).on('turbolinks:load', function () {
  $('[data-submit]').on('click', function (e) {
    e.preventDefault()
    $(this.getAttribute('data-submit')).submit();
  })
})
