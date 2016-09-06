## react-native-cookies

Cookie manager for react native.

### Installation

1. `npm install react-native-cookies`
2. `rnpm link react-native-cookies` - (run `npm install -g rnpm` if required)
3. Om nom nom nom cookies.

### Usage

```javascript
var CookieManager = require('react-native-cookies');

// set a cookie (IOS ONLY)
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

// Set cookies from a response header
// This allows you to put the full string provided by a server's Set-Cookie 
// response header directly into the cookie store.
CookieManager.setFromResponse('http://example.com', 'user_session=abcdefg; path=/; expires=Thu, 1 Jan 2030 00:00:00 -0000; secure; HttpOnly', (res) => {
  // `res` will be true or false depending on success.
  console.log("Set cookie", res);
})

// Get cookies as a request header string
CookieManager.get('http://example.com', (err, res) => {
  console.log('Got cookies for url', res);
  // Outputs 'user_session=abcdefg; path=/;'
})

// list cookies (IOS ONLY)
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

// clear a specific cookie by its name (IOS ONLY)
CookieManager.clearByName('cookie_name', (err, res) => {
  console.log('cookie cleared!');
  console.log(err);
  console.log(res);
});

```

### Roadmap

- Proper `getAll` dictionary by domain
- Proper error handling
- Anything else?

PR's welcome!
