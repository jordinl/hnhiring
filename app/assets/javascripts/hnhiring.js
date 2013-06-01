HNHiring = {
  initialize: function(){
    this.set_dates();
    this.zebrify();
    this.bind_events();
  },

  set_dates: function(){
    $.each($('.timestamp'), function(index, element){
      timestamp = $(element).text();
      date = (new Date(timestamp)).toDateString();
      time = (new Date(timestamp)).toTimeString().split(' ')[0];
      $(element).siblings('.date').html(date + ' at ' + time);
    });
  },

  zebrify: function(){
    $('.comment').removeClass('even');
    $('.comment:not(.hidden):even').addClass('even');
  },

  bind_events: function(){
    $('.filter').keyup(function(){
      HNHiring.highlight_word($.trim(this.value));
    })
  },

  highlight_word: function(words){
    $('#content').removeHighlight();
    $('.comment').removeClass('hidden');
    $.each(words.split(' '), function(index, word){
      if(word.length > 1){
        $.each($('.comment'), function(index, element){
          if(!$(element).html().toUpperCase().match(word.toUpperCase())){
            $(element).addClass('hidden');
          }
        })
        $('#content').highlight(word);
      }
    });
    HNHiring.zebrify();
  }
}

$(document).ready(function(){

  HNHiring.initialize();

});


