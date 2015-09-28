//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require owl.carousel
//= require highlight/highlight.js

$(document).ready(function() {
  hljs.initHighlightingOnLoad();
  
  $(".owl-carousel-1").owlCarousel({
    items: 1,
    itemsDesktop: false,
    itemsDesktopSmall: false,
    itemsTablet: false,
    itemsTabletSmall: false,
    itemsMobile: false,
    itemsCustom: false
  });
  
  $(".owl-carousel-2").owlCarousel({
    items: 2,
    itemsDesktop: false,
    itemsDesktopSmall: false,
    itemsTablet: false,
    itemsTabletSmall: false,
    itemsMobile: false,
    itemsCustom: [[400, 1], [640, 2]]
  });
  
  $(".owl-carousel-3").owlCarousel({
    items: 3,
    itemsDesktop: false,
    itemsDesktopSmall: false,
    itemsTablet: false,
    itemsTabletSmall: false,
    itemsMobile: false,
    itemsCustom: [[400, 1], [640, 2], [800, 3]]
  });
});