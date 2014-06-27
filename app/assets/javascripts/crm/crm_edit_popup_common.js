$(document).ready(function(){
	$("#add-new-task").click(function(){
		popup_edit_task(0);
		return false;
	})

});



function popup_edit_task_save(save_and_exit){
	if(typeof save_and_exit == 'undefined') save_and_exit = 0;

	popup_edit_save({
		controller: 'tasks',
		save_and_exit: save_and_exit,
		onSuccess: function(data){
			$(".float-container .window-chat-container").html(data.msg);
			containerPosition($(".float-container .window-chat-wrapper"), 1);

			$(".float-container .window-chat textarea[name=comment]").val('');
		}
	});

	return false;
}



function popup_edit_task(item_id){
	popup_edit_form({
		controller: 'tasks',
		item_id: item_id,
		onComplete: function(){
			// update save events
			$(".float-container .float-buttons .save").click(function(){
				popup_edit_task_save();
				return false;
			})
			$("input[name=tasktime]").keyup(function(){
				addDeltaMinutes();
			});
			var calStart = new Calendar({
				inputField: "start_date",
				dateFormat: "%d.%m.%Y %H:%M",
				trigger: "start_date",
				weekNumbers: true,
				onSelect: function(cal) {
					var date = Calendar.intToDate(this.selection.get());
					calEnd.args.min = date;
					calEnd.redraw();
					this.hide();
					taskTime();

				},
				showTime: true,
			});

			var calEnd = new Calendar({
				inputField: "end_date",
				dateFormat: "%d.%m.%Y %H:%M",
				trigger: "end_date",
				weekNumbers: true,
				onSelect: function(cal) {
					this.hide();
					taskTime();
				},
				bottomBar: true,
				showTime: true,
			});

			$(".float-container .float-buttons .save-and-exit").click(function(){
				popup_edit_task_save(1);
				return false;
			})
			$(".float-container .float-buttons .delete").click(function(){
				if( confirm('Точно удаляем задачу?') ) popup_edit_delete( {controller: 'tasks'} );
				return false;
			})
		}
	});
}

