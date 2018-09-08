HNHiring = {
  initialize: function(){
    this.bind_events();
  },

  zebrify: function(){
    $('.comment').removeClass('odd');
    if($('.comment.hidden').length > 0) {
      $('li.comment:not(.hidden):odd').addClass('odd');
    } else {
      $('li:odd.comment').addClass('odd');
    }
  },

  bind_events: function(){
    $('.filter').keyup(function(){
      HNHiring.highlight_word($.trim(this.value));
    })
  },

  highlight_word: function(words){
    $('.comments').removeHighlight();
    $('.comment').removeClass('hidden');
    $.each(words.split(' '), function(index, word){
      if(word.length > 2){
        $.each($('.comment'), function(index, element){
          if(!$(element).html().toUpperCase().match(word.toUpperCase())){
            $(element).addClass('hidden');
          }
        })
        $('.comments').highlight(word);
      }
    });
    HNHiring.zebrify();
  }
}

$(document).ready(function(){

  HNHiring.initialize();

});


