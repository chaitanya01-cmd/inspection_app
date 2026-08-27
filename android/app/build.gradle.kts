plugins {
    id("com.android.application")
<<<<<<< HEAD
=======
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
>>>>>>> 7f1b1ee8ae437682cb91dd8b4ab4d45ce3e500f6
    id("dev.flutter.flutter-gradle-plugin")
}

android {
<<<<<<< HEAD
    namespace = "com.example.flutter_application_1"
    compileSdk = 36

    defaultConfig {
        applicationId = "com.example.flutter_application_1"
        minSdk = flutter.minSdkVersion
        targetSdk = 37
        versionCode = 1
        versionName = "1.0"
    }
=======
    namespace = "com.example.camera_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "28.2.13676358"
>>>>>>> 7f1b1ee8ae437682cb91dd8b4ab4d45ce3e500f6

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
<<<<<<< HEAD
=======

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.camera_app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        // Uses the version code from pubspec.yaml. When using split APKs, 1000 * ABI_VERSION
        // is added automatically by Flutter. (https://developer.android.com/studio/build/configure-apk-splits#configure-APK-versions)
        // You can force using the value of versionCode by specifying the `-P force-version-code-ignoring-abi=true`
        // flag during build.
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
>>>>>>> 7f1b1ee8ae437682cb91dd8b4ab4d45ce3e500f6
}

kotlin {
    compilerOptions {
<<<<<<< HEAD
        jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
=======
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
>>>>>>> 7f1b1ee8ae437682cb91dd8b4ab4d45ce3e500f6
    }
}

flutter {
    source = "../.."
<<<<<<< HEAD
}
=======
}
>>>>>>> 7f1b1ee8ae437682cb91dd8b4ab4d45ce3e500f6
