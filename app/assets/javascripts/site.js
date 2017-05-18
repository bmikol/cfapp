$(document).on('turbolinks:load', function () {
  // Make alerts fade-in/fade-out
  $('.alert').delay(3000).fadeOut(2000)
  // Use Raty plugin for comment ratings
  $('.rating').raty({ path: '/assets', scoreName: 'comment[rating]' })
  $('.rated').raty({ path: '/assets',
    readOnly: true,
    score: function () {
      return $(this).attr('data-score')
    }
  })
  // Use elevateZoom plugin for zooming in on images
  $('.img-zoom').elevateZoom({
    zoomType: 'inner',
    cursor: 'crosshair'
  })
})
