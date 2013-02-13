// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require plugins
//= require_self

$(function(){
  setTimeout(function(){
    $('p.notice, p.message').fadeTo('slow', 0, function(){ $(this).remove() })
  },3000);
  $(window).bind('load', function(){
    window.scrollTo(0,1);
  });

  // Error animation
  // hide smash on startup
  $('#smash').css('bottom', -420);

  var clickCount = 0;

  var win = {}

  function refreshWinSizes() {
    win.w = $(window).width();
    win.h = $(window).height();
  }

  refreshWinSizes();

  $(window).resize(function(){
    refreshWinSizes();
  });

  // when all images are loaded, smash slides up
  $(window).load(function(){
    $('#smash').animate( {bottom: -135}, 500, 'easeOutQuart');
  });


  // init some vars for eyeball movement
  var pupils = {
    e: $('#smash .pupils')
  };
  pupils.x = parseInt( pupils.e.css('left') );
  pupils.y = parseInt( pupils.e.css('top') );


  var hilites = {
    e: $('#smash .hilites')
  };
  hilites.x = parseInt( $('#smash .hilites').css('left') ),
  hilites.y = parseInt( $('#smash .hilites').css('top') )


  // eyeball movement animation
  $(document).mousemove( function(e) {

    var cursor = {
      x: ( e.pageX / win.w ) * 2 - 1,
      y: ( e.pageY / win.h ) * 2 - 1
    }

    pupils.moveX = parseInt( cursor.x * 28  + pupils.x);
    pupils.moveY = parseInt( cursor.y * 25  + pupils.y);

    hilites.moveX = parseInt( cursor.x * 7  + hilites.x);
    hilites.moveY = parseInt( cursor.y * 6  + hilites.y);

    pupils.e.css({
      left: pupils.moveX,
      top: pupils.moveY
    });

    hilites.e.css({
      left: hilites.moveX,
      top: hilites.moveY
    });

  });

  // shimmy-shake animation
  var shakeEasing = 'swing';
  var clickMax = 5;

  $('.skull')
    .css('cursor', 'pointer')
    .click(function(event){

      var shakeSpeed =  event.shiftKey ? 800 : 100;

      if ( clickCount <= clickMax ) {
        $('#smash')
          .animate({left: -50, bottom: -60}, shakeSpeed, shakeEasing)
          .animate({left: 50, bottom: -15}, shakeSpeed, shakeEasing)
          .animate({left: -50}, shakeSpeed, shakeEasing)
          .animate({left: 50, bottom: -60}, shakeSpeed, shakeEasing)
          .animate({left: 0, bottom: -135}, shakeSpeed, shakeEasing);
      } else if ( clickCount > clickMax ) {
        $('#smash').animate({bottom: -420}, 500, shakeEasing);
      }

      if (clickCount == clickMax) {
        $(this).append('<a href="http://gdzl.la/795z3i" />');
      }

      clickCount ++;
    });

});
