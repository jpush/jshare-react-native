# jshare-react-native

## Install

```
npm install jshare-react-native --save
npm install jcore-react-native@1.1.5 --save
react-native link
```

## Manually Configure Part

### Android

- [Checkout configuration](./docs/AndroidConfig.md)
- [Add JSharePackage, Don't forget the parameters !](./docs/JSharePackage.md)
- [Checkout AndroidManifest](./docs/AndroidManifest.md)
- [Add WXEntryActivity](./docs/WXEntryActivity.md)

That's it.

### iOS

- [configure iOS](./docs/iOSConfig.md)

## Usage

- Import JShareModule:

  > your component.js

  ```
  ...
  import JShareModule from 'jshare-react-native';
  ```

- Use JShareModule call APIs, [API Document](./docs/API.md)

