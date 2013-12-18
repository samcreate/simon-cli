/*! modal class
 * @depends plugins/handlebars-1.0.rc.1.js
 */

var CHANGE_ME = CHANGE_ME || {};
CHANGE_ME.modal = function () {

	var modal_source   = $('#modal-template').html(),
		modal_template = Handlebars.compile(modal_source);
		
	var self = {
			init: function () {
				debug.log('[modal.js] - initialized');
				setupBinds();
			},
			show: function (content, classes) {
				var data = { 
						'content': content,
						'classes': classes
					},
					modal = modal_template(data);
				$(document.body).append(modal);

				fixFacebookTabPosition();
			},
			close: function () {
				$('.overlay').remove();
				$('.modal').remove();
			}
		};

	return self;

	function setupBinds () {

		$(document.body).on('click', '.overlay, .close', function (e) {
			e.preventDefault();
			CHANGE_ME.modal.close();
		});

		$(document).keyup(function (e) {
			if (e.keyCode == 27) CHANGE_ME.modal.close();
		});
	}

	function fixFacebookTabPosition () {
		if (CHANGE_ME.util.is_tablet && CHANGE_ME.util.is_iframe) {
			FB.Canvas.getPageInfo(function (info) {
				var y_diff = info.scrollTop + 200;
				$('.modal').css('position', 'absolute').css('top', y_diff);
			});
		}
	}
	
}();
CHANGE_ME.main.queue(CHANGE_ME.modal.init);