## react-native-cookies

Cookie manager for react native.

[![npm version](https://badge.fury.io/js/react-native-cookies.svg)](https://badge.fury.io/js/react-native-cookies)
[![npm downloads](https://img.shields.io/npm/dm/react-native-cookies.svg)](https://www.npmjs.com/package/react-native-cookies)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/joeferraro/react-native-cookies/master/LICENSE.md)




### Installation

```
yarn add react-native-cookies
```

### Linking

#### Automatic (recommended)

```
react-native link react-native-cookies
```

#### Manual

If automatic linking does not work, you can manually link this library by following the instructions below:

##### iOS

1. Open your project in Xcode, right click on `Libraries` and click `Add
   Files to "Your Project Name"` Look under `node_modules/react-native-cookies/ios` and add `RNCookieManagerIOS.xcodeproj`.
2. Add `libRNCookieManagerIOS.a` to `Build Phases -> Link Binary With Libraries.
3. Clean and rebuild your project

##### Android

Run `react-native link` to link the react-native-cookies library.

Or if you have trouble, make the following additions to the given files manually:

**android/settings.gradle**

```gradle
include ':react-native-cookies'
project(':react-native-cookies').projectDir = new File(rootProject.projectDir, '../node_modules/react-native-cookies/android')
```

**android/app/build.gradle**

```gradle
dependencies {
   ...
   compile project(':react-native-cookies')
}
```

**MainApplication.java**

On top, where imports are:

```java
import com.psykar.cookiemanager.CookieManagerPackage;
```

Add the `CookieManagerPackage` class to your list of exported packages.

```java
@Override
protected List<ReactPackage> getPackages() {
    return Arrays.asList(
            new MainReactPackage(),
            new CookieManagerPackage()
    );
}
```



### Usage

```javascript
import CookieManager from 'react-native-cookies';

// set a cookie (IOS ONLY)
CookieManager.set({
  name: 'myCookie',
  value: 'myValue',
  domain: 'some domain',
  origin: 'some origin',
  path: '/',
  version: '1',
  expiration: '2015-05-30T12:30:00.00-05:00'
}).then((res) => {
  console.log('CookieManager.set =>', res);
});

// Set cookies from a response header
// This allows you to put the full string provided by a server's Set-Cookie 
// response header directly into the cookie store.
CookieManager.setFromResponse(
  'http://example.com', 
  'user_session=abcdefg; path=/; expires=Thu, 1 Jan 2030 00:00:00 -0000; secure; HttpOnly')
    .then((res) => {
      // `res` will be true or false depending on success.
      console.log('CookieManager.setFromResponse =>', res);
    });

// Get cookies as a request header string
CookieManager.get('http://example.com')
  .then((res) => {
    console.log('CookieManager.get =>', res); // => 'user_session=abcdefg; path=/;'
  });

// list cookies (IOS ONLY)
CookieManager.getAll()
  .then((res) => {
    console.log('CookieManager.getAll =>', res);
  });

// clear cookies
CookieManager.clearAll()
  .then((res) => {
    console.log('CookieManager.clearAll =>', res);
  });

// clear a specific cookie by its name (IOS ONLY)
CookieManager.clearByName('cookie_name')
  .then((res) => {
    console.log('CookieManager.clearByName =>', res);
  });

```

### TODO

- Proper `getAll` dictionary by domain
- Proper error handling
- Anything else?

PR's welcome!
