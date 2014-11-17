// Expandir Menu Lateral

$(function ($) {
  $('#principal a').click(function () {
    $('body').toggleClass('lateral-activo');
  });
});

// Expandir Detalles de Articulo

$(function ($) {
  $('footer button').click(function () {
    $(this).prev('ul').slideToggle();
    $(this).toggleClass('expanded');
  });
});


// Resaltar Articulo


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
            shrinkOn = 500,
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

