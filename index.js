var React = require('react-native');
var NativeModules = React.NativeModules;
var Platform = React.Platform;
var invariant = require('invariant');
var RNCookieManagerIOS = NativeModules.RNCookieManagerIOS;
var RNCookieManagerAndroid = NativeModules.RNCookieManagerAndroid;

var CookieManager;
if (Platform.OS === 'ios') {
    invariant(RNCookieManagerIOS,
            'Add RNCookieMangerIOS.h and RNCookieManagerIOS.m to your Xcode project');
    CookieManager = RNCookieManagerIOS;
} else if (Platform.OS === 'android') {
    invariant(RNCookieManagerAndroid, 'Import libraries to android "rnpm link"');
    CookieManager = RNCookieManagerAndroid;
} else {
    invariant(CookieManager, "Invalid platform");
}

var functions = [
    'set',
    'setFromResponse',
    'get',
    'getAll',
    'clearAll'
];

module.exports = {}
for (var i=0; i < functions.length; i++) {
    module.exports[functions[i]] = CookieManager[functions[i]];
}