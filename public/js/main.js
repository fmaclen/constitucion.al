jQuery(document).ready(function ($) {
    $('button').click(function () {
      $(this).prev('ul').toggle();
      $(this).toggleClass('expanded');
    });
});