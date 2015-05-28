var NativeModules = require('NativeModules');
var RNCookieManagerIOS = NativeModules.RNCookieManagerIOS;

module.exports = {
  set(props, callback) {
    RNCookieManagerIOS.set(props, (err, res) => {
      callback(err, res);
    });
  },
  clearAll(callback) {
    RNCookieManagerIOS.clearAll((err, res) => {
      callback(err, res);
    });
  },
  getAll(callback) {
    RNCookieManagerIOS.getAll((err, res) => {
      callback(err, res);
    });
  }
}
