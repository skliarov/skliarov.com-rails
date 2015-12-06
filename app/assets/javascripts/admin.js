//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require highlight/highlight.js

$(document).ready(function() {
  // Highlight syntax
  hljs.initHighlightingOnLoad();
  
  // Show or hide mobile menu
  $('nav.mobile .breadcrumb a').on('click', function(event) {
    event.preventDefault();
    $('nav.desktop').toggleClass('open');
  });
  
  $('#screencasts').sortable({
    update: function() {
      $.post($(this).data('update-url'), $(this).sortable('serialize'));
    }
  });
});