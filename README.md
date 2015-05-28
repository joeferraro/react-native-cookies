## react-native-cookies

Cookie manager for react native.

### Installation

1. `npm install react-native-cookies`
2. In the XCode's "Project navigator", right click on project's name ➜ `Add Files to <...>`
3. Go to `node_modules` ➜ `react-native-cookies` ➜ add `RNCookieManagerIOS` folder
4. Compile and have some cookies

### Usage

```javascript
var CookieManager = require('react-native-cookies');

// set a cookie
CookieManager.set({
  name: 'myCookie',
  value: 'myValue',
  domain: 'some domain',
  origin: 'some origin',
  path: '/',
  version: '1',
  expiration: '2015-05-30T12:30:00.00-05:00'
}, (err, res) => {
  console.log('cookie set!');
  console.log(err);
  console.log(res);
});

// list cookies
CookieManager.getAll((err, res) => {
  console.log('cookies!');
  console.log(err);
  console.log(res);
});

// clear cookies
CookieManager.clearAll((err, res) => {
  console.log('cookies cleared!');
  console.log(err);
  console.log(res);
});

```

### Roadmap

- Expose `get` method
- Proper `getAll` dictionary by domain
- Proper error handling
- Anything else?

PR's welcome!
