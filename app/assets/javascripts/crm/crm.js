var	editor = null,
	PAGE = 1,
	CONTROLLER = '',
	order = null,
	order_type = null,
	searchTimer = null;

$(document).ready(function(){
	$("body").click(function(){
		$(".filter").removeClass("opened");
	});

	$("#topbar-menu .noempty span").click(function(e){
		e.stopPropagation();

		if(!$("#topbar-menu .add-links a.current").length) return false;

		if($("#topbar-menu .add-links a.current").data('popup')){
			window[ $("#topbar-menu .add-links a.current").data('popup') ](0);
			return false;
		}

		window.location.href=$("#topbar-menu .add-links a.current").attr('href');

		return false;
	});


	$("#list").on("click", ".sort, .az, .za", function(){
		var sortType = 'asc';
		var $divCont = $(this).closest('div');



		if( $(this).hasClass('az') ){
			sortType = 'asc';

		} else if( $(this).hasClass('za') ){
			sortType = 'desc';

		} else{
			// reverse sort
			if( $divCont.find('a.az.current').length ){
				sortType = 'desc';

			} else if( $divCont.find('a.za.current').length  ){
				sortType = 'asc';

			} else {
				sortType = 'asc';

			}
		}

		$("#list .sort, .az, .za").removeClass('current');

		if(sortType == 'asc'){
			$divCont.find('a.az').addClass('current');
		} else {
			$divCont.find('a.za').addClass('current');
		}
		order = $(this).closest("div").data('order');
		order_type = sortType;

		items_list( filter() );
		return false;
	});

	$('#qsearch').keyup(function(e) {
		if(searchTimer) clearTimeout(searchTimer);

		searchTimer = setTimeout(function(){
			items_list(filter());
		}, 500);
	});

	$("#chb_toogleAllChecked").click(function(){
		$("#list").find("input.chb_selectItem").attr('checked', $(this).is(':checked'));
	})

});

function items_list(extradata){
	var data = jQuery.extend({
		page: PAGE,
		beforeSend: function(){},
		success: function(){},
		action: 'list_items',
		container_items: 'list-items'
	}, extradata);

	if($("#qsearch").length && $("#qsearch").val().length ) data['qsearch'] = $("#qsearch").val();

	if($("#sort a.az-current").length){
		data['order'] = $("#sort a.az-current").parents("div:first").attr('field');
		data['order_type'] = 'asc';
	} else if($("#sort a.za-current").length){
		data['order'] = $("#sort a.za-current").parents("div:first").attr('field');
		data['order_type'] = 'desc';
	}

	var container_items = data.container_items;
	delete data.container_items;
	var action = data.action;
	delete data.action;
	var beforeSend = data.beforeSend;
	delete data.beforeSend;
	var success = data.success;
	delete data.success;

	$.ajax({
		//url: "/crm/"+CONTROLLER+"/"+action,
		url: "/crm/"+CONTROLLER+".js",
		beforeSend: function(){
				$("#"+container_items).addClass("loading-items").css('cursor', 'progress');
				beforeSend();
		},

		success: function(data){
				$("#"+container_items).removeClass("loading-items").html(data.html);
				success(data);
		},

		error: function(data){
			$("#"+container_items).html('<span style="color:red;">Ошибка загрузки списка...</span>').css('cursor', 'default');
		},
		complete:function(){
			$("#"+container_items).css('cursor', 'default');
		},
		data: data,
	});
}


function setFilterEvent(userdata){
	var args = jQuery.extend({
		label: '',
		lkey: '',
		onSubmit: function(){
			items_list(filter());
		}
	}, userdata);

	var $filter = $("#filter-"+args.lkey+"");

	$filter.data('label-all-checked', args.label);

	$filter.find('span').click(function(e){
		e.stopPropagation();

		if ($(this).closest(".filter").is(".opened")) {
			$("body").click();
		} else {
			$("body").click();
			$(this).closest(".filter").toggleClass("opened");
		}
	});
	$filter.click(function(e){
		e.stopPropagation();
	});

	$filter.find("a.ok").click(function(e){
		e.stopPropagation();

		if($(this).hasClass('radio-filter')){
			_setRadioFilter( $filter, args.lkey );

		} else if($(this).hasClass('checkbox-filter')){
			_setCheckboxFilter( $filter, args.lkey );
		}

		args.onSubmit();

		$("body").click();
		return false;
	});

	if($filter.find("a.ok").hasClass('radio-filter')){
		_setRadioFilter( $filter, args.lkey );

	} else if($filter.find("a.ok").hasClass('checkbox-filter')){
		_setCheckboxFilter( $filter, args.lkey );
	}
}

function _setCheckboxFilter($filter, lkey){
	var name = [];

	if( $filter.find("input[name=filter_input_"+lkey+"]:checked ").length){
		$filter.find("input[name=filter_input_"+lkey+"]:checked ").each(function(){
			if($(this).hasClass('checkall')) return true;

			name.push( $(this).parent().text() );
		})
	}

	$filter.find("span").eq(0).text(name.length ? name.join(', ') : $filter.data('label-all-checked'));
	$filter.find("span").eq(1).text(name.length ? name.join(', ') : $filter.data('label-all-checked'));
}

function _setRadioFilter($filter, lkey){
	var name = $filter.data('label-all-checked');

	if( !$filter.find("input[name=filter_input_"+lkey+"]:checked ").length ){
		$("input[name=filter_input_"+lkey+"]:first").attr('checked', true);

	} else if( $filter.find("input[name=filter_input_"+lkey+"]:checked ").val() != 0){
		name = $filter.find("input[name=filter_input_"+lkey+"]:checked ").parent().text();
	}

	$filter.find("span").eq(0).text(name);
	$filter.find("span").eq(1).text(name);
}
