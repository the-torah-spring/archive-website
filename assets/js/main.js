/*! Plugin options and other jQuery stuff */

// dl-menu options
$(function() {
  $( '#dl-menu' ).dlmenu({
    animationClasses : { classin : 'dl-animate-in', classout : 'dl-animate-out' }
  });
});

$(".close-menu").click(function () {
  $(".menu").toggleClass("disabled");
  $(".links").toggleClass("enabled");
});

// Inline popups
$(document).ready(function() {
  $('.issue-info').magnificPopup({
    delegate: 'a',
    type: 'inline',
    
    gallery: {enabled: true},
    
    fixedContentPos: true,
    fixedBgPos: true,

    overflowY: 'scroll',

    closeBtnInside: true,
    preloader: false,
    
    midClick: true,
    removalDelay: 500,
    mainClass: 'mfp-move-horizontal',
  });
});
