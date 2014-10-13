// Expandir Detalles de Articulo

$(function ($) {
  $('button').click(function () {
    $(this).prev('ul').slideToggle();
    $(this).toggleClass('expanded');
  });
});


// Resaltar Articulo

$(function() {
  $('a[name="' + window.location.hash.replace(/#/, '') + '"]').next('section').addClass('resaltado')
});
