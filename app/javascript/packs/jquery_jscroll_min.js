$(window).on('scroll', function() {
  scrollHeight = $(document).height();
  scrollPosition = $(window).height() + $(window).scrollTop();
  if ( (scrollHeight - scrollPosition) / scrollHeight <= 0.05) {
        $('.jscroll').jscroll({
          contentSelector: '.top-right',
          nextSelector: 'span.next a',
          loadingHtml: '読み込み中',
          autoTrigger: true,
          padding: 1,
        });
  }
});