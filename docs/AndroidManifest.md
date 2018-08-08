# AndroidManifest Configuration

> your project/android/app/AndroidManifest.xml

```
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    package="your package name">

    <uses-sdk
        android:minSdkVersion="16"
        android:targetSdkVersion="22"
        tools:STRICT="com.facebook.react"/>

    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW"/>

    <application
        android:name=".MainApplication"
        android:allowBackup="true"
        android:icon="@drawable/ic_launcher"
        android:label="@string/app_name"
        android:theme="@style/AppTheme">
        <activity
            android:name=".MainActivity"
            android:configChanges="keyboard|keyboardHidden|orientation|screenSize"
            android:label="@string/app_name"
            android:launchMode="singleTask">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>

        <!-- Required. For publish channel feature -->
        <!-- JPUSH_CHANNEL 是为了方便开发者统计APK分发渠道。-->
        <!-- 例如: -->
        <!-- 发到 Google Play 的APK可以设置为 google-play; -->
        <!-- 发到其他市场的 APK 可以设置为 xxx-market。 -->
        <!-- 目前这个渠道统计功能的报表还未开放。-->
        <meta-data android:name="JPUSH_CHANNEL" android:value="${JPUSH_CHANNEL}"/>
        <meta-data android:name="JPUSH_APPKEY" android:value="${JPUSH_APPKEY}"/>
        <meta-data android:name="JSHARE_PKGNAME" android:value="${applicationId}" />
        <meta-data android:name="TENCENT_APPID" android:value="${TENCENT_APPID}" />

        <activity android:name="com.facebook.react.devsupport.DevSettingsActivity" />
        <!-- Optional 微信分享回调,wxapi必须在包名路径下，否则回调不成功-->
        <activity
            android:name=".wxapi.WXEntryActivity"
            android:theme="@android:style/Theme.NoTitleBar"
            android:exported="true" />
        <!-- Optional facebook配置,authorities必须为com.facebook.app.FacebookContentProvider+APP_ID-->
        <provider
            android:authorities="com.facebook.app.FacebookContentProvider177776412817787"
            android:name="cn.jiguang.share.facebook.FacebookContentProvider"
            android:exported="true" />    
    </application>


</manifest>
```

