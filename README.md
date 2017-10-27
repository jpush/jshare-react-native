# jshare-react-native

## Install

```
npm install jshare-react-native --save
npm install jcore-react-native --save
react-native link
```

## Manually Configure Part

### Android

- [Checkout configuration](./docs/AndroidConfig.md)
- [Add JSharePackage, Don't forget the parameters !](./docs/JSharePackage.md)
- [Checkout AndroidManifest](./docs/AndroidManifest.md)
- [Add JGShareSDK.xml](./docs/JGShareSDK.md)
- [Add WXEntryActivity](./docs/WXEntryActivity.md)

That's it.

### iOS

- [configure iOS](./docs/iOSConfig.md)

## Usage

- Import JShareModule:

  > your component.js

  ```javascript
  ...
  import JShareModule from 'jshare-react-native';
  JShareModule.setup(param) // iOS 调用该方法才能正常使用， param 参考 API 文档
  ```

- Use JShareModule call APIs, [API Document](./docs/API.md)

