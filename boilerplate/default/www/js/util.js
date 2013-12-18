/*! util class
 * Put javascript plugin depedencies below (see main.js for an exmaple)
 * 
 */
var CHANGE_ME = CHANGE_ME || {};
CHANGE_ME.util = function () {
	// =================================================
	// = Private variables (example: var _foo = bar; ) =
	// =================================================


	// =================================================
	// = public functions                              =
	// =================================================
	var self = {

		// vars
		is_tablet: (/ipad|android|android 3.0|xoom|sch-i800|playbook|tablet|kindle/i.test(navigator.userAgent.toLowerCase())),
		is_iframe: (window.self != window.top),

		// functions
		convert_mysql_date: function (mysqldate) {
			// accepts a mysql timestamp string (ie. "2010-06-09 13:12:01"), returns a Date object.
			var t = mysqldate.split(/[- :]/);
			var d = new Date(t[0], t[1]-1, t[2], t[3], t[4], t[5]);
			return d;
		},
		time_elapsed: function (date) { 
			// accepts a Date object (from the past), and returns a string describing the time elapsed. 
			
			// JavaScript Pretty Date / Copyright (c) 2008 John Resig (jquery.com) / Licensed under the MIT license.
			var diff = (((new Date()).getTime() - date.getTime()) / 1000),
			day_diff = Math.floor(diff / 86400);
									
			if ( isNaN(day_diff) || day_diff < 0 ) return;
			
			if (day_diff >= 31) return "over a month ago";

			var v = day_diff == 0 && (
				diff < 60 && "just now" ||
				diff < 120 && "1 minute ago" ||
				diff < 3600 && Math.floor( diff / 60 ) + " minutes ago" ||
				diff < 7200 && "1 hour ago" ||
				diff < 86400 && Math.floor( diff / 3600 ) + " hours ago") ||
				day_diff == 1 && "Yesterday" ||
				day_diff < 7 && day_diff + " days ago" ||
				day_diff < 31 && Math.ceil( day_diff / 7 ) + " weeks ago";
			if (!v)
				window.console && console.log(date);
			return v ? v : '';
		}
		
	};
	
	return self;



	// ================================================
	// = Private functionse (function _private () {}) =
	// ================================================

}();