$(document).on ("turbolinks:load", function() {
	$('.alert').delay(3000).fadeOut(2000);
	$('.rating').raty({ path: '/assets', scoreName: 'comment[rating]' });
	$('.rated').raty({ path: '/assets',
		readOnly: true,
		score: function() {
			return $(this).attr('data-score');
		}
	});
});