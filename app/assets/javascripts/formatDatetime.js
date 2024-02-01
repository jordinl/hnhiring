$(document).on('turbolinks:load', function () {
  $('[data-format-datetime]').each(function () {
    var $el = $(this);

    function setCountdown() {
      var difference = Math.floor(($el.data('format-datetime') - new Date().getTime()) / 1000)
      var seconds = difference % 60
      difference = Math.floor(difference / 60)
      var minutes = difference % 60
      difference = Math.floor(difference / 60)
      var hours = difference % 24
      var days = Math.floor(difference / 24)
      var text = [
        days > 0 ? `${days}d` : null,
        hours > 0 || days > 0 ? `${hours}h` : null,
        minutes > 0 || days > 0 || hours > 0 ? `${minutes}m` : null,
        `${seconds}s`
      ].filter(_ => _).join(' ')
      $el.text(text)
    }

    setCountdown()

    setInterval(setCountdown, 1000)
  })
})
