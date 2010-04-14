$(document).ready(function(){
	$('#menu .menu-item')
		.mouseover(changeSelectedMenuItem)
		.mouseout(changeSelectedMenuItem);
        $('#control-panel a.menu-item')
		.mouseover(changeSelectedMenuItem)
		.mouseout(changeSelectedMenuItem);
        $('a.ajax').attr('href','javascript:void()');
});
function changeSelectedMenuItem(){
	$(this).toggleClass('selected');
}

function showWindow(id){
		$('.window').hide();
		$win = $('#'+id+'');
		$win.css('left',(window.innerWidth - $win.width()) /2);
		$win.css('top',window.innerHeight/2  - $win.height());
		$win.slideDown();
}