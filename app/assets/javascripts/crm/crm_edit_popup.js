$(document).ready(function(){
	// float windows
	$(".float").draggable({
		containment: "parent",
		handle: "ul li.current",
		start: function() {

		},
		drag: function(){

		},
		stop: function() {
			replaceFloatOnResize();
		}
	});


	// float windows tabs
	$(".tabs-menu a").click(function(){
		if ($(this).closest("li").is(".current")) return false;
		var maxzindex = 0;
		$(this).closest(".tabs-menu").find("li").removeClass("current").each(function(){
			maxzindex = $(this).css("z-index") > (maxzindex || 0) ? parseInt($(this).css("z-index")) : maxzindex;
		});
		$(this).closest("li").addClass("current").css("z-index", (maxzindex+1));

		return false;
	});

	$("#popup-wrapper").on('click', '.save', function(){
		popup_edit_save({
			controller: $(this).data('controller'),
		});
		return false;
	})

	$("#popup-wrapper").on('click', '.save-and-exit', function(){
		popup_edit_save({
			save_and_exit: 1,
			controller: $(this).data('controller'),
		});
		return false;
	})

	$("#popup-wrapper").on('click', '.delete', function(){
		if( !confirm('Точно удаляем задачу?') ) return false;

		popup_edit_delete({
			controller: $(this).data('controller'),
		});
		return false;
	})

	$("#popup-wrapper").on('click', '.float-close', function(){
		toogle_popup_edit();
		return false;
	});
});

$(window).resize(function(){
	replaceFloatOnResize();
	replaceConverterOnResize();
});

function replaceConverterOnResize() {
	var converter = $("#converter");
	if (converter.length > 0) {
		var window_width = $("body").width();
		var window_height = $("body").height();
		var width = converter.width();
		if (parseInt(converter.css("left"), 10)+width+20 > window_width) {
			converter.css("left", window_width-width-(20*2));
			if (window_width-width-(20*2) < 20) {
				converter.css("left", 0);
			}
		}
		var height = converter.height();
		if (parseInt(converter.css("top"), 10)+height+10 > window_height || parseInt(converter.css("top"), 10) < 0) {
			converter.css("top", window_height-height-(10*2));
			if (window_height-height-(10*2) < 0) {
				converter.css("top", 0);
			}
		}
	}
}

function replaceFloatOnResize() {
	var floatbox = $(".float:visible");
	if (floatbox.length > 0) {
		var window_width = $("body").width();
		var window_height = $("body").height();
		var float_margin_left = parseInt(floatbox.css("margin-left"), 10);
		var width = floatbox.width();
		if (parseInt(floatbox.css("left"), 10)+width+float_margin_left > window_width) {
			floatbox.css("left", window_width-width-(float_margin_left*2));
			if (window_width-width-(float_margin_left*2) < float_margin_left) {
				floatbox.css("left", 0);
			}
		}
		var float_margin_top = parseInt(floatbox.css("margin-top"), 10);
		var height = floatbox.height();
		if (parseInt(floatbox.css("top"), 10)+height+float_margin_top > window_height || parseInt(floatbox.css("top"), 10) < 0) {
			floatbox.css("top", window_height-height-(float_margin_top*2));
			if (window_height-height-(float_margin_top*2) < 0) {
				floatbox.css("top", 0);
			}
		}
	}
}

function toogle_popup_edit() {
	if( $('.float').css('display') == 'block' ){
		$('.float').fadeOut();
		$("#blackbox").hide();
	} else {
		$("#blackbox").show();
		$('.float').fadeIn();
	}

	return false;
};

function popup_edit_form(userargs){
	var args = jQuery.extend({
		item_id: 0,
		onComplete: function(){},
		controller: CONTROLLER,
	}, userargs);

	toogle_popup_edit();

	var url = args.item_id ? "/crm/"+args.controller+"/"+args.item_id : "/crm/"+args.controller+"/new";

	$.ajax({
		url: url,
		dataType: 'html',
		beforeSend: function(){
			$("#blackbox").show();
			$("#popup-wrapper").html('').addClass('loading-popup').show();

			replaceFloatOnResize();

		},

		success: function(data){
			$("#popup-wrapper").removeClass('loading-popup').html(data);
			args.onComplete();

			replaceFloatOnResize();
		},

		error: function(data){
		},
	});
}

function popup_edit_delete(userargs){
	var args = jQuery.extend({
		onComplete: function(){},
		controller: CONTROLLER,
	}, userargs);

	var index = $("#popup-wrapper input[name=ID]").val();
	if(index){
		document.location.href = "/crm/"+args.controller+"/list?delete="+index;
	}
}

function popup_edit_save(userargs){
	var args = jQuery.extend({
		item_id: 0,
		onComplete: function(){},
		onSuccess: function(){},
		onCompleteSaveAndExit: function(){
			toogle_popup_edit();

			if(args.controller == CONTROLLER){
				items_list( filter() );
			} else {
				document.location.href = '/crm/'+args.controller+'/list';
			}

			return false;
		},
		controller: CONTROLLER,
		save_and_exit: 0,
	}, userargs);

	var $msg = $("#popup-wrapper .message");
	var data = $("#popup-edit-form").serialize();


	$.ajax({
		url: "/crm/"+args.controller+"/edit_popup",
		type: 'post',
		beforeSend: function(){
			$msg.css('color', 'green').text('Cохраняем ..');
		},

		success: function(data){
			if(data.errors){
				$msg.css('color', 'red').html(data.errors);
			} else {
				if(args.save_and_exit){
					args.onCompleteSaveAndExit();

					return false;
				}
				$("#popup-wrapper input[name=ID]").val(data.ID);
				$("#popup-wrapper .delete").fadeIn('slow');

				args.onSuccess(data);

				$msg.css('color', 'green').text('Данные сохранены');
				setTimeout(function(){
					$msg.text('');
				}, 3000)
			}
		},

		error: function(data){
			$msg.css('color', 'green').text('Системная ошибка :(');
		},
		data: data
	});
}