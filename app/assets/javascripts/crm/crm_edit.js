$(function(){
	$("#container .rightCol .submit").click(function(){
		if($(this).attr('id') == 'save-and-continue'){
			$("#container input[name=continue]").val(1);
		}
		else {
			$("#container input[name=continue]").val('');
		}

		$('#container form').submit();
		return false;
	});
})