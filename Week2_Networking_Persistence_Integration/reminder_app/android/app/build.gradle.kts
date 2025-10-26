// DÁN TOÀN BỘ CODE NÀY VÀO FILE: android/app/build.gradle.kts

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.reminder_app"

    // YÊU CẦU: SỬA DÒNG NÀY THÀNH 34
    compileSdk = 34

    ndkVersion = flutter.ndkVersion

    compileOptions {
        // SỬA THÀNH 1.8
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        // SỬA THÀNH 1.8
        jvmTarget = "1.8"
    }

    defaultConfig {
        applicationId = "com.example.reminder_app"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Không cần thêm gì ở đây
}