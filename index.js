import React from 'react';
import {NativeModules, Platform} from 'react-native';
const invariant = require('invariant');
const RNCookieManagerIOS = NativeModules.RNCookieManagerIOS;
const RNCookieManagerAndroid = NativeModules.RNCookieManagerAndroid;

let CookieManager;

if (Platform.OS === 'ios') {
    invariant(RNCookieManagerIOS,
        'Add RNCookieMangerIOS.h and RNCookieManagerIOS.m to your Xcode project');
    CookieManager = RNCookieManagerIOS;
} else if (Platform.OS === 'android') {
    invariant(RNCookieManagerAndroid, 
        'Import libraries to android "rnpm link"');
    CookieManager = RNCookieManagerAndroid;
} else {
    invariant(CookieManager, 'Invalid platform. This library only supports Android and iOS.');
}

var functions = [
    'set',
    'setFromResponse',
    'getFromResponse',
    'get',
    'getAll',
    'clearAll',
    'clearByName'
];

module.exports = {}
for (var i=0; i < functions.length; i++) {
    module.exports[functions[i]] = CookieManager[functions[i]];
}
