/*
Загрузка карточки товара посредством AJAX.

Назначаем событие клика по строкам прайса.
$(document).ready(function(event){
  $("td.t").click(productClick);
});
*/

$(document).ready(function(event){
  attachProductEvents();
});

function attachProductEvents(){
    $("td.t a")
        .click(productClick)
        .attr('href','javascript:void()');
}

var $productLine; // Активная строка прайса

// Первый раз кликаем по строке прайса
function productClick(event){
	// Получаем элемент самой строки.
	$productLine = $(event.target.parentNode.parentNode);
        $(event.target).text('Загрузка...');
	// Загружаем карточку товара. Id хранится в name строки прайса.
	loadExtended($productLine.attr('name'));
}

// Запрос AJAX
function loadExtended(id){
	$.ajax({data:'',
		success:loadedSuccess, 
		type:'post', url:'/store/product_card/'+id+'/'}); 
}
// Загрузка завершена
function loadedSuccess(request){
	// Заменяем на копию строку прайса
        $productLine.find('.price-item').hide();
        $newLine = new jQuery(request);
        $newLine.find('.product-card').hide();
        $productLine = $productLine.replaceWith($newLine);
        $newLine.find('.product-image-container:first').show();
        $newLine.find('.product-card').slideDown();
        //$newLine.slideDown();
}
function showNext(sender){
    if($(sender.parentNode.parentNode).next('.product-image-container').length > 0){
        $(sender.parentNode.parentNode).next('.product-image-container').show();   
        $(sender.parentNode.parentNode).hide();
    }
}
function showPrev(sender){
    if($(sender.parentNode.parentNode).prev('.product-image-container').length > 0){
        $(sender.parentNode.parentNode).prev('.product-image-container').show();   
        $(sender.parentNode.parentNode).hide();
    }
}