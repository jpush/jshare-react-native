# Android Configure Part

## Checkout settings.gradle

> your project/android/settings.gradle

```
include ':app', ':jshare-react-native', ':jcore-react-native'
project(':jshare-react-native').projectDir = new File(rootProject.projectDir, '../node_modules/jshare-react-native/android')
project(':jcore-react-native').projectDir = new File(rootProject.projectDir, '../node_modules/jcore-react-native/android')
```

## Checkout module's build.gradle, add configuration

> your project/android/app/build.gradle

```
android {
  ...
  defaultConfig {
    applicationId "your application id"    // <-- 包名、应用的签名、第三方平台注册的 AppID 及 Appkey 三者要一一对应，否则会无法分享
    ...
    manifestPlaceholders = [
      JPUSH_APPKEY: "your app key",	        // <--    在此替换你的APPKey
      JPUSH_CHANNEL: "developer-default",		// <--    应用渠道号, 默认即可
    ]
  }
  sourceSets {      // <--   必须添加 sourceSet 这段。因为 JGShareSDK.xml 放在 assets 下，不加上会报错。
    main {
        assets.srcDirs = ['assets']
    }
  }
  ...
  signingConfigs {
        debug {
            storeFile file("jshare.jks") //签名文件路径
            storePassword "sdkteam"
            keyAlias "jshare"
            keyPassword "sdkteam" //签名密码
        }
        release {
            storeFile file("jshare.jks") //签名文件路径
            storePassword "sdkteam"
            keyAlias "jshare"
            keyPassword "sdkteam" //签名密码
        }
    }
     buildTypes {
        release {
            minifyEnabled enableProguardInReleaseBuilds
            proguardFiles getDefaultProguardFile("proguard-android.txt"), "proguard-rules.pro"
            signingConfig signingConfigs.debug
        }
        debug {
            signingConfig signingConfigs.debug
        }
    }
    ...
    dependencies {
      compile project(':jshare-react-native')     // <-- JShare 依赖
      compile project(':jcore-react-native')      // <-- JCore 依赖
   }
}
```

​




