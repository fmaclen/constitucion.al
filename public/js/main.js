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

$(function() {
  $('a[name="' + window.location.hash.replace(/#/, '') + '"]').next('section').addClass('resaltado')
});

