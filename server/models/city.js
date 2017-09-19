'use strict';

module.exports = (City) => {
      // define remote method
  City.getCity = (data) => {
    return new Promise((resolve, reject) => {
      resolve(data);
    });
  };

      // expose remote method
  City.remoteMethod('getCity', {
    accepts: {arg: 'data', type: 'object', http: {source: 'body'}},
    returns: {arg: 'data', type: 'object', root: true},
    http: {path: '/find', verb: 'post'},
  });
};
