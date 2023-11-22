# flutter_openinstall_plugin
The openinstall flutter plugin upgraded based on `https://github.com/OpenInstall/openinstall-flutter-plugin`

# Features
- Android upgrades to Koltin
- iOS upgrades to swift
- Upgrade Kotlin to `1.7.10`
- Upgrade Gradle daemon to `7.5`
- Upgrade Gradle build plugin to `7.3.0`
- Upgrade Flutter SDK to `>=3.2.0 <4.0.0`
- Upgrade Android channel methods async supported

# Integrations

Flutter
--
Using `FlutterOpeninstallPlugin`

Android
--

`~/android/app/src/main/AndroidManifest.xml`
```xml
...
<manifest xmlns:android="http://schemas.android.com/apk/res/android" xmlns:tools="http://schemas.android.com/tools">
...
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
...
<application
...
    tools:node="replace">
<activity
...>
    <intent-filter>
        <action android:name="android.intent.action.MAIN"/>
        <category android:name="android.intent.category.LAUNCHER"/>
        <category android:name="android.intent.category.BROWSABLE"/>
        <data android:scheme="${AppKey}"/>
    </intent-filter>
</activity>
...
    <meta-data android:name="com.openinstall.APP_KEY" android:value="${AppKey}"/>
...
</application>
</manifest>
```




iOS
--
ignored
