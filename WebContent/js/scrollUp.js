/**
 * 버튼의 스크롤을 상단으로 보내는 javascript
 */

$(function(){
	$('#fixButton').click(function(){
		$('html, body').animate({scrollTop:0}, 500);
	});
});