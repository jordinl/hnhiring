$(document).on('turbolinks:load', function () {
  $('[data-format-datetime]').each(function () {
    var $el = $(this);

    function setCountdown() {
      var difference = Math.floor(($el.data('format-datetime') - new Date().getTime()) / 1000)
      var seconds = difference % 60
      var rest = Math.floor(difference / 60)
      var minutes = rest % 60
      rest = Math.floor(rest / 60)
      var hours = rest % 24
      var days = Math.floor(rest / 24)
      var text = [
        days > 0 ? `${days}d` : null,
        hours > 0 || days > 0 ? `${hours}h` : null,
        minutes > 0 || days > 0 || hours > 0 ? `${minutes}m` : null,
        difference < 60 && seconds > 0 ? `${seconds}s` : null,
        difference < 0 ? 'soon' : null
      ].filter(_ => _).join(' ')
      $el.text(text)
    }

    setCountdown()

    setInterval(setCountdown, 1000)
  })
})
