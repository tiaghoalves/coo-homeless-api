'use strict';

module.exports = (Location) => {
      // define remote method
  Location.getLocation = (data) => {
    return new Promise((resolve, reject) => {
      resolve(data);
    });
  };

      // expose remote method
  Location.remoteMethod('getLocation', {
    accepts: {arg: 'data', type: 'object', http: {source: 'body'}},
    returns: {arg: 'data', type: 'object', root: true},
    http: {path: '/find', verb: 'post'},
  });
};
