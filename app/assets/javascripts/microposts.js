
$(document).ready(function(){

	$("textarea#micropost_content").bind('textchange', function(){
		var content = $(this).val();
		var charsLeft = 140-parseInt(content.length);
		countSpan = $("span#micropost-chars-count");
		countSpan.text(charsLeft);
		if (charsLeft >= 0)
			countSpan.removeClass('error').addClass('success');
		else
			countSpan.removeClass('success').addClass('error');
	});

});