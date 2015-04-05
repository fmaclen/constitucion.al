// Expandir Menu Lateral

$(function ($) {
  $('#principal a').click(function () {
    $('body').toggleClass('lateral-activo');
  });
});

// Expandir Detalles de Articulo

$(function ($) {
  $('header button').click(function () {
    $(this).closest('section').toggleClass('expandido');
  });
});

// Header Rotativo

$(function() {

    var quotes = $(".rotativos");
    var quoteIndex = -1;

    function showNextQuote() {
        ++quoteIndex;
        quotes.eq(quoteIndex % quotes.length)
            .fadeIn(500)
            .delay(2000)
            .fadeOut(500, showNextQuote);
    }

    showNextQuote();

});

// Resaltar Articulo

$(function() {
  $('a[name="' + window.location.hash.replace(/#/, '') + '"]').next('section').addClass('resaltado')
});

// Animacion al cambiar de articulo

$(function() {
  if(window.location.hash) {
    var targetHash = $('a[name="' + window.location.hash.replace(/#/, '') + '"]')
    $(targetHash).next('section').addClass('resaltado')
    $('html,body').animate({
      scrollTop: targetHash.offset().top
    }, 1000);
    return false;
  }
});

$(function() {
  $('a[href*=#]:not([href=#])').click(function() {
    if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
      var target = $(this.hash);
      target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
      if (target.length) {
        $('section').removeClass('resaltado')
        $(target).next('section').addClass('resaltado')
        $('html,body').animate({
          scrollTop: target.offset().top
        }, 1000);
        return false;
      }
    }
  });
});


// Animacion del Header

function init() {
    window.addEventListener('scroll', function(e){
        var distanceY = window.pageYOffset || document.documentElement.scrollTop,
            shrinkOn = 350,
            header = document.querySelector("body");
        if (distanceY > shrinkOn) {
            classie.add(header,"achicado");
        } else {
            if (classie.has(header,"achicado")) {
                classie.remove(header,"achicado");
            }
        }
    });
}
window.onload = init();


// Google Analytics

(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-1560276-22', 'auto');
ga('send', 'pageview');


