import async from 'async';

export default (app) => {
	let models = [];
	let calls = [];

	models.push(app.models.contributor);
	models.push(app.models.organization);
	models.push(app.models.donation_status);

	if (models.length > 0) {
		models[0].dataSource.setMaxListeners(0);

		models.forEach((model) => {
			if (model.defaultData) {
				model.defaultData.forEach((value) => {
					calls.push(addDefaultData(model, value));
				});
			}
		});
	}



	async.parallel(calls, (err, data) => {
		if (err) {
			console.log(err);
		}
	});
}

let addDefaultData = (model, value) => {
	return (cb) => {
		model.create(value, (err) => {
			if (err) console.log('Error:', err);
		});
	};
}
