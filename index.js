import React from 'react';
import { NativeModules, Platform } from 'react-native';
const invariant = require('invariant');
const RNCookieManagerIOS = NativeModules.RNCookieManagerIOS;
const RNCookieManagerAndroid = NativeModules.RNCookieManagerAndroid;

let CookieManager;

if (Platform.OS === 'ios') {
    invariant(RNCookieManagerIOS,
        'react-native-cookies: Add RNCookieManagerIOS.h and RNCookieManagerIOS.m to your Xcode project');
    CookieManager = RNCookieManagerIOS;
} else if (Platform.OS === 'android') {
    invariant(RNCookieManagerAndroid,
        'react-native-cookies: Import libraries to android "react-native link react-native-cookies"');
    CookieManager = RNCookieManagerAndroid;
} else {
    invariant(CookieManager, 'react-native-cookies: Invalid platform. This library only supports Android and iOS.');
}

const functions = [
    'set',
    'setFromResponse',
    'getFromResponse',
    'get',
    'getAll',
    'clearAll',
    'clearByName'
];

module.exports = {}
for (var i = 0; i < functions.length; i++) {
    module.exports[functions[i]] = CookieManager[functions[i]];
}
