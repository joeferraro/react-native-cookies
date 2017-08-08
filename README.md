## react-native-cookies

Cookie manager for react native.

### Installation

```
yarn add react-native-cookies
react-native link react-native-cookies
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
  console.log('cookie set!');
  console.log(err);
  console.log(res);
});

// Set cookies from a response header
// This allows you to put the full string provided by a server's Set-Cookie 
// response header directly into the cookie store.
CookieManager.setFromResponse(
  'http://example.com', 
  'user_session=abcdefg; path=/; expires=Thu, 1 Jan 2030 00:00:00 -0000; secure; HttpOnly')
    .then((res) => {
      // `res` will be true or false depending on success.
      console.log('set cookie result', res);
    });

// Get cookies as a request header string
CookieManager.get('http://example.com')
  .then((res) => {
    console.log('cookies for url', res); // => 'user_session=abcdefg; path=/;'
  });

// list cookies (IOS ONLY)
CookieManager.getAll()
  .then(res) => {
    console.log('all cookies', res);
  });

// clear cookies
CookieManager.clearAll()
  .then(res) => {
    console.log('cookies cleared', res);
  });

// clear a specific cookie by its name (IOS ONLY)
CookieManager.clearByName('cookie_name')
  .then(res) => {
    console.log('cookie cleared', res);
  });

```

### Roadmap

- Proper `getAll` dictionary by domain
- Proper error handling
- Anything else?

PR's welcome!
