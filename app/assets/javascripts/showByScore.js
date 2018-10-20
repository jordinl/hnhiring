$(document).on('turbolinks:load', function () {
  $('[data-show-by-score]').each(function() {
    $top = $(this);
    var limit = $top.data('show-by-score');

    var $elements = $top.find('[data-score]');
    var sortedElements = $elements.sort(function(a, b) {
      return b.dataset.score - a.dataset.score
    });

    function hideElements() {
      var count = 0;

      sortedElements.each(function () {
        var $element = $(this);

        if(count < limit) {
          $element.removeClass('hidden')
        } else {
          $element.addClass('hidden')
        }

        count += 1;
      });
    }

    hideElements();

    var $link = $("<a href='#'>Show More<i class='fas fa-angle-down' /></a>")
    var $div = $("<div class='center toggle col-12'></div>")
    $div.append($link)
    $top.append($div)

    $link.on('click', function (e) {
      e.preventDefault();

      if($elements.hasClass('hidden')) {
        $elements.removeClass('hidden');
        $link.html("Show Less<i class='fas fa-angle-up' />")
      } else {
        hideElements();
        $link.html("Show More<i class='fas fa-angle-down' />")
      }
    })
  })
})
