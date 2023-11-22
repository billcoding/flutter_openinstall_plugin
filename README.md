# flutter_openinstall_plugin
The flutter plugin for openinstall upgraded based on https://github.com/OpenInstall/openinstall-flutter-plugin

# Features
- Android upgrades to Kotlin
- iOS upgrades to swift
- Upgrade Kotlin to `1.7.10`
- Upgrade Gradle daemon to `7.5`
- Upgrade Gradle build plugin to `7.3.0`
- Upgrade Flutter SDK to `>=3.2.0 <4.0.0`
- Upgrade Android channel methods async supported

# Integrations

Flutter
--
Using `FlutterOpenInstallPlugin` static methods

Android
--
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
