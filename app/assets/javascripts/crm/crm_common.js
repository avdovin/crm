function Sound(filename) {
	var audioObjSupport = false, audioTagSupport = false, self = this, ext;
	if (!filename) throw 'Undefined filename';

	try {
		var audioObj = document.createElement('audio');

		audioObjSupport = !!(audioObj.canPlayType);

		if (('no' != audioObj.canPlayType('audio/mpeg')) && ('' != audioObj.canPlayType('audio/mpeg')))
			ext = '.mp3?1';
		else if (('no' != audioObj.canPlayType('audio/ogg; codecs="vorbis"')) && ('' != audioObj.canPlayType('audio/ogg; codecs="vorbis"')))
			ext = '.ogg?1';
		else
			audioObjSupport = false;
	} catch (e) {}
	// audioObjSupport = false;

	if (audioObjSupport) {
		audioObj.src = '/crm/sound/' + filename + ext;
		var ended = false;
		audioObj.addEventListener('ended', function(){ended = true;}, true);
		audioObj.load();
		this.playSound = function() {
			if (ended) {
				audioObj.load();
			}
			audioObj.play();
			ended = false;
		};
		this.pauseSound = function() {
			audioObj.pause();
		};
	}
}

Sound.prototype = {
	play: function() {
		try {this.playSound();} catch(e){}
	},
	pause: function() {
		try {this.pauseSound();} catch(e){}
	}
};

function taskTime() {
	if( $("#start_date").val() && $("#end_date").val() ){
		var dateTimeParts = $("#start_date").val().split(" ");
		var dateParts = dateTimeParts[0].split('.')
		var timeParts = dateTimeParts[1].split(":");
		var Date1 = new Date(dateParts[2], dateParts[1]-1, dateParts[0], timeParts[0], timeParts[1]);

		dateTimeParts = $("#end_date").val().split(" ");
		dateParts = dateTimeParts[0].split('.')
		timeParts = dateTimeParts[1].split(":");
		var Date2 = new Date(dateParts[2], dateParts[1]-1, dateParts[0], timeParts[0], timeParts[1]);

		var ms = Date2.getTime() - Date1.getTime();
		var sec = Math.floor(ms / 1000);
		var min = Math.floor(sec / 60);
		$("input[name=tasktime]").val(min);
	}
}

function addDeltaMinutes(){
	if( $("#start_date").val() ){
		var dateTimeParts = $("#start_date").val().split(" ");
		var dateParts = dateTimeParts[0].split('.')
		var timeParts = dateTimeParts[1].split(":");
		var sDate = new Date(dateParts[2], dateParts[1]-1, dateParts[0], timeParts[0], timeParts[1]);

		var deltaMin = parseInt( $("input[name=tasktime]").val() ) || 0;
		sDate.setMinutes(sDate.getMinutes()+deltaMin);

		//var setMonth = parseInt(sDate.getMonth())+1;

		$("#end_date").val(
			("00" + sDate.getDate()).slice(-2) + "." +
			("00" + (sDate.getMonth() + 1)).slice(-2) + "." +
			 sDate.getFullYear() + " " +
			("00" + sDate.getHours()).slice(-2) + ":" +
			("00" + sDate.getMinutes()).slice(-2)
		);
		//$("#end_date").val(
		//	sDate.getDate()+'.'+setMonth+'.'+sDate.getFullYear()+' '+( sDate.getHours() < 10 ? "0" : "" ) + sDate.getHours()+':'+sDate.getMinutes()  );
	}

}