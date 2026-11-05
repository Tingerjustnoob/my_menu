import com.android.build.api.dsl.ApplicationExtension

plugins {
    id("com.android.internal.application")
    id("dev.flutter.flutter-gradle-plugin")
}

configure<ApplicationExtension> {
    namespace = "com.example.e_commerce"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    // 正確關鍵：內建 Kotlin 會自動讀取這裡的 JavaVersion.VERSION_17 作為 jvmTarget！
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "com.example.e_commerce"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
            isShrinkResources = false
            isMinifyEnabled = false
        }
    }
}

flutter {
    source = "../.."
}
