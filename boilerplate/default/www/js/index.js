/*! index class
 * Put javascript plugin depedencies below (see main.js for an exmaple)
 * 
 */
var CHANGE_ME = CHANGE_ME || {};
CHANGE_ME.index = function () {
	// =================================================
	// = Private variables (example: var _foo = bar; ) =
	// =================================================

	
	
	// =================================================
	// = public functions                              =
	// =================================================
	var self = {
		
		init : function () {

			debug.group("# [index.js]");

				debug.log('[index.js] - initialized'); 

				//--> sof private functions

					_setupBinds();

				//--> eof private functions

			debug.groupEnd();

		}
		
	};
	
	return self;

	
	
	// ================================================
	// = Private functionse (function _private () {}) =
	// ================================================
	function _setupBinds () {

		$(document.body).on('click', '.show-modal', function (e) {
			e.preventDefault();
			CHANGE_ME.modal.show('hi! this is a modal!', 'hello-modal');
		});

	}
	
}();
//CHANGE_ME.main.queue(CHANGE_ME.index.init);


