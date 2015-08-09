var NativeModules = require('react-native').NativeModules;
var invariant = require('invariant');
var RNCookieManagerIOS = NativeModules.RNCookieManagerIOS;

module.exports = {
  set(props, callback) {
    invariant(
      NativeModules.RNCookieManagerIOS,
      'Add RNCookieManagerIOS.h and RNCookieManagerIOS.m to your Xcode project.'
    );
    RNCookieManagerIOS.set(props, (err, res) => {
      callback(err, res);
    });
  },
  clearAll(callback) {
    invariant(
      NativeModules.RNCookieManagerIOS,
      'Add RNCookieManagerIOS.h and RNCookieManagerIOS.m to your Xcode project.'
    );
    RNCookieManagerIOS.clearAll((err, res) => {
      callback(err, res);
    });
  },
  getAll(callback) {
    invariant(
      NativeModules.RNCookieManagerIOS,
      'Add RNCookieManagerIOS.h and RNCookieManagerIOS.m to your Xcode project.'
    );
    RNCookieManagerIOS.getAll((err, res) => {
      callback(err, res);
    });
  }
}
