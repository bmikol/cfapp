var refreshRating = function () {
  // Use Raty plugin for comment ratings
  $('.rating').raty({ path: '/assets', scoreName: 'comment[rating]' })
  $('.rated').raty({ path: '/assets',
    readOnly: true,
    score: function () {
      return $(this).attr('data-score')
    }
  })
}

$(document).on('turbolinks:load ajaxSuccess', function () {
  refreshRating()
  // Make alerts fade-in/fade-out
  $('.alert').delay(3000).fadeOut(2000)
  // Use elevateZoom plugin for zooming in on images
  $('.img-zoom').elevateZoom({
    zoomType: 'inner',
    cursor: 'crosshair'
  })
})
