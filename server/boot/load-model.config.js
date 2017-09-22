// TO-DO: Change to ES6
module.exports = function(app) {
	var async = require('async');
    var models = [];
    var calls = [];

    models.push(app.models.origem_mercadoria);
    models.push(app.models.cst_icms);

    if (models.length > 0) {
        models[0].dataSource.setMaxListeners(0);
        models.forEach(function(model) {
            if (model.defaultData) {
                model.defaultData.forEach(function(value) {
                    calls.push(function(cb) {
                        model.create(value, function(err) {
							if (err) {
								console.log('Error:', err);
							}
						});
                    });
                });
            }
        });
    }

    async.parallel(calls, function(err, data) {
        if (err) {
            console.log(err)
        }
    });
}
