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
<intent-filter>
...
    <category android:name="android.intent.category.BROWSABLE"/>
    <data android:scheme="abcdefg"/>
...
</intent-filter>
```

`~/andriod/app/build.gradle`
```
defaultConfig {
...
manifestPlaceholders += [ 'OPENINSTALL_APPKEY': 'abcdefg' ]
...
}
```

iOS
--
ignored
