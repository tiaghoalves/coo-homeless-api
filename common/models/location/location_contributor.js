'use strict';

module.exports = (LocationContributor) => {
	// define remote method
	LocationContributor.getLocation = (data) => {
		return new Promise((resolve, reject) => {
			resolve(data);
		});
	};

	// expose remote method
	LocationContributor.remoteMethod('getLocation', {
		accepts: { arg: 'data', type: 'object', http: { source: 'body' } },
		returns: { arg: 'data', type: 'object', root: true },
		http: { path: '/find', verb: 'post' },
	});

	LocationContributor.remoteMethod('getNearbyLocation', {
		accepts: { arg: 'loc', type: 'GeoPoint' },
		returns: { arg: 'location', type: 'GeoPoint' }
	});
};
