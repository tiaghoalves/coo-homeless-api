'use strict';

module.exports = (City) => {
	// define remote method
	City.getLocation = (data) => {
		return new Promise((resolve, reject) => {
			resolve(data);
		});
	};

	// expose remote method
	City.remoteMethod('getLocation', {
		accepts: { arg: 'data', type: 'object',
			http: {
				source: 'body'
			}
		},
		returns: { arg: 'data', type: 'object', root: true },
		http: {
			path: '/find',
			verb: 'post'
		},
	});

	City.remoteMethod('getNearbyLocation', {
		accepts: { arg: 'loc', type: 'GeoPoint' },
		returns: { arg: 'location', type: 'GeoPoint' }
	});
};
