$(document).on('turbolinks:load', function () {
  $('[data-format-datetime]').each(function () {
    var $el = $(this);
    var date = new Date($el.data('format-datetime'))
    var dateString = date.toLocaleString('en-us', { year: 'numeric', month: 'long', day: 'numeric' })
    var timeString = date.toLocaleString('en-us', { hour: 'numeric' })
    $el.text(dateString + ' at ' + timeString)
  })
})
