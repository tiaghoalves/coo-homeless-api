'use strict';

module.exports = (Localization) => {
	// define remote method
	Localization.getLocation = (data) => {
		return new Promise((resolve, reject) => {
			resolve(data);
		});
	};

	// expose remote method
	Localization.remoteMethod('getLocation', {
		accepts: { arg: 'data', type: 'object', http: { source: 'body' } },
		returns: { arg: 'data', type: 'object', root: true },
		http: { path: '/find', verb: 'post' },
	});

	Localization.remoteMethod('getNearbyLocation', {
		accepts: { arg: 'loc', type: 'GeoPoint' },
		returns: { arg: 'location', type: 'GeoPoint' }
	});
};