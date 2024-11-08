## Project Structure 📂
```
Quiz-Genius
│
├── .github
│   ├── ISSUE_TEMPLATE
│   │   ├── bug_report.md
│   │   ├── documentation-update-issue-template.md
│   │   ├── feature-improvement-issue-template.md
│   │   └── feature_request.md
│   └── workflows
│       ├── flutter.yml
│       ├── Greetings.yml
│       ├── issue-open-close.yml
│       ├── pr-checker.yaml
│       ├── pr-merge.yml
│       └── restrict.yml
│
├── .vscode
│   ├── launch.json
│   └── settings.json
│
├── android
│   ├── .gitignore
│   ├── .gradle
│   │   ├── 8.7
│   │   ├── checksums
│   │   ├── checksums.lock
│   │   ├── expanded
│   │   ├── fileChanges
│   │   ├── fileHashes
│   │   ├── gc.properties
│   │   ├── last-build.bin
│   │   └── vcsMetadata
│   ├── app
│   │   ├── build.gradle
│   │   ├── google-services.json
│   │   └── src
│   │       ├── debug
│   │       ├── main
│   │       │   ├── AndroidManifest.xml
│   │       │   ├── kotlin
│   │       │   │   └── com
│   │       │   │       └── example
│   │       │   │           └── quiz_genius
│   │       │   │               └── MainActivity.kt
│   │       │   └── res
│   │       │       ├── drawable
│   │       │       │   ├── background.png
│   │       │       │   └── launch_background.xml
│   ├── build.gradle
│   ├── gradle
│   │   └── wrapper
│   │       └── gradle-wrapper.properties
│   ├── gradle.properties
│   └── settings.gradle
│
├── assets
│   └── images
│       ├── gssocextd.jpg
│       ├── hacktoberfest.png
│       ├── icon.png
│       ├── login.svg
│       ├── online_test.svg
│       ├── Screenshot_1.png
│       ├── Screenshot_2.png
│       ├── Screenshot_3.png
│       └── Screenshot_4.png
│
├── ios
│   ├── Flutter
│   ├── Runner
│   ├── Runner.xcodeproj
│   ├── Runner.xcworkspace
│   └── RunnerTests
│
├── lib
│   ├── firebase
│   │   └── auth.dart
│   ├── firebase_options.dart
│   ├── main.dart
│   ├── models
│   │   ├── current_user.dart
│   │   ├── previous_questions.dart
│   │   ├── questions.dart
│   │   └── scores.dart
│   ├── pages
│   │   ├── forgot_password.dart
│   │   ├── home_page.dart
│   │   ├── login_page.dart
│   │   ├── previous_quiz_page.dart
│   │   ├── previous_scores_page.dart
│   │   ├── profile_page.dart
│   │   ├── quiz_mcq_page.dart
│   │   ├── quiz_page.dart
│   │   ├── signUp_page.dart
│   │   ├── splash_screen.dart
│   │   └── username_page.dart
│   └── utils
│       ├── colors.dart
│       ├── extensions.dart
│       ├── my_route.dart
│       ├── profile_image_service.dart
│       └── toast.dart
│
├── Linux
│   ├── .gitignore
│   ├── CMakeLists.txt
│   ├── flutter
│   │   ├── CMakeLists.txt
│   │   ├── generated_plugins.cmake
│   │   ├── generated_plugin_registrant.cc
│   │   └── generated_plugin_registrant.h
│   ├── main.cc
│   ├── my_application.cc
│   └── my_application.h
│
├── macos
│   ├── .gitignore
│   ├── firebase_app_id_file.json
│   ├── Flutter
│   │   ├── Flutter-Debug.xcconfig
│   │   ├── Flutter-Release.xcconfig
│   │   └── GeneratedPluginRegistrant.swift
│   ├── Podfile
│   ├── Runner
│   │   ├── AppDelegate.swift
│   │   ├── Assets.xcassets
│   │   │   ├── app_icon_1024.png
│   │   │   ├── app_icon_128.png
│   │   │   ├── app_icon_16.png
│   │   │   ├── app_icon_256.png
│   │   │   ├── app_icon_32.png
│   │   │   ├── app_icon_512.png
│   │   │   ├── app_icon_64.png
│   │   │   └── Contents.json
│   │   ├── Base.lproj
│   │   │   └── MainMenu.xib
│   │   ├── Configs
│   │   ├── AppInfo.xcconfig
│   │   ├── Debug.xcconfig
│   │   ├── Release.xcconfig
│   │   ├── Warnings.xcconfig
│   │   ├── DebugProfile.entitlements
│   │   ├── GoogleService-Info.plist
│   │   ├── Info.plist
│   │   ├── MainFlutterWindow.swift
│   │   └── Release.entitlements
│   ├── Runner.xcodeproj
│   │   ├── project.pbxproj
│   │   ├── project.xcworkspace
│   │   └── xcshareddata
│   │       ├── IDEWorkspaceChecks.plist
│   │       └── xcschemes
│   │           └── Runner.xcscheme
│   ├── Runner.xcworkspace
│   │   ├── contents.xcworkspacedata
│   │   └── xcshareddata
│   │       └── IDEWorkspaceChecks.plist
│   └── RunnerTests
│       └── RunnerTests.swift
│
├── test
│   └── widget_test.dart
│
├── web
│   ├── favicon.png
│   ├── icons
│   │   ├── Icon-192.png
│   │   ├── Icon-512.png
│   │   ├── Icon-maskable-192.png
│   │   └── Icon-maskable-512.png
│   ├── index.html
│   ├── manifest.json
│   └── splash
│       └── img
│           ├── dark-1x.png
│           ├── dark-2x.png
│           ├── dark-3x.png
│           ├── dark-4x.png
│           ├── light-1x.png
│           ├── light-2x.png
│           ├── light-3x.png
│           └── light-4x.png
│
├── windows
│   ├── .gitignore
│   ├── CMakeLists.txt
│   ├── flutter
│   │   ├── CMakeLists.txt
│   │   ├── generated_plugins.cmake
│   │   ├── generated_plugin_registrant.cc
│   │   └── generated_plugin_registrant.h
│   └── runner
│       ├── CMakeLists.txt
│       ├── flutter_window.cpp
│       ├── flutter_window.h
│       ├── main.cpp
│       ├── resource.h
│       ├── resources
│       │   └── app_icon.ico
│       ├── runner.exe.manifest
│       ├── Runner.rc
│       ├── utils.cpp
│       ├── utils.h
│       ├── win32_window.cpp
│       └── win32_window.h
│
├── .gitignore
├── .metadata
├── CODE_OF_CONDUCT.md
├── CONTRIBUTING.md
├── LICENSE
├── README.md
├── analysis_options.yaml
├── flutter_01.png
├── pubspec.lock
```
