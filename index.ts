import * as React from 'react';
import { NativeModules, Platform } from 'react-native';
import * as invariant from 'invariant';

const RNCookieManagerIOS = NativeModules.RNCookieManagerIOS;
const RNCookieManagerAndroid = NativeModules.RNCookieManagerAndroid;

const LINKING_ERROR_MESSAGE = 'react-native-cookies does not seem to be linked propery. See https://github.com/joeferraro/react-native-cookies#linking';

let CookieManager;

if (Platform.OS === 'ios') {
  invariant(RNCookieManagerIOS, LINKING_ERROR_MESSAGE);
  CookieManager = RNCookieManagerIOS;
} else if (Platform.OS === 'android') {
  invariant(RNCookieManagerAndroid, LINKING_ERROR_MESSAGE);
  CookieManager = RNCookieManagerAndroid;
} else {
  invariant(CookieManager, 'react-native-cookies: Invalid platform. This library only supports Android and iOS.');
}

type Cookie = {
  name?: string;
  value?: string;
  domain?: string;
  origin?: string;
  path?: string;
  version?: string;
  expiration?: string;
};

export const set = (options: Cookie): void => CookieManager.set(options);
export const setFromResponse = (url: string, headerOptions: string): void => CookieManager.setFromResponse(url, headerOptions);
export const get = (url: string): Cookie => CookieManager.get(url);
export const getFromResponse = (url: string): Cookie => CookieManager.getFromResponse(url);
export const getAll = (): Array<Cookie> => CookieManager.getAll();
export const clearAll = (): void => CookieManager.clearAll();
export const clearByName = (cookieName: string): void => CookieManager.clearByName(cookieName);