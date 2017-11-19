'use strict';

module.exports = (LocationOng) => {
	// define remote method
	LocationOng.getLocation = (data) => {
		return new Promise((resolve, reject) => {
			resolve(data);
		});
	};

	// expose remote method
	LocationOng.remoteMethod('getLocation', {
		accepts: { arg: 'data', type: 'object', http: { source: 'body' } },
		returns: { arg: 'data', type: 'object', root: true },
		http: { path: '/find', verb: 'post' },
	});

	LocationOng.remoteMethod('getNearbyLocation', {
		accepts: { arg: 'loc', type: 'GeoPoint' },
		returns: { arg: 'location', type: 'GeoPoint' }
	});
};
