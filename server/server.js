'use strict';

import loopback from 'loopback';
import boot from 'loopback-boot';

import http from 'http';
import https from 'https';
import sslConfig from './ssl-config';

const app = module.exports = loopback();
// start the web server
app.start = (httpOnly) => {
	if (httpOnly === undefined) {
		httpOnly = process.env.HTTP;
	}
	let server = null;

	if (!httpOnly) {
		let options = {
			key: sslConfig.privateKey,
			cert: sslConfig.certificate,
		};
		server = https.createServer(options, app);
	} else {
		server = http.createServer(app);
	}
	
	server.listen(app.get('port'), () => {
		const baseUrl = (httpOnly ? 'http://' : 'https://') + app.get('host') + ':' + app.get('port');
		app.emit('started', baseUrl);
		console.log('Web server listening at: %s%s', baseUrl, '/');
		
		if (app.get('loopback-component-explorer')) {
			const explorerPath = app.get('loopback-component-explorer').mountPath;
			console.log('Browse your REST API at %s%s', baseUrl, explorerPath);
		}
	});

	return server;
}
// Bootstrap the application, configure models, datasources and middleware.
// Sub-apps like REST API are mounted via boot scripts.
boot(app, __dirname, err => {
	if (err) throw err;

	// start the server if `$ node server.js`
	if (require.main === module)
		app.start();
});
