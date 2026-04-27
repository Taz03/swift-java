import org.jetbrains.kotlin.gradle.plugin.mpp.KotlinNativeTarget

plugins {
    alias(libs.plugins.kotlin.multiplatform)
    alias(libs.plugins.kotlinx.serialization)
}

group = "com.example.swift"
version = "unspecified"

repositories {
    mavenCentral()
}

kotlin {
    macosArm64()
    iosArm64()
    iosSimulatorArm64()

    targets.withType<KotlinNativeTarget>().configureEach {
        binaries.executable {
            entryPoint = "com.example.swift.main"
        }
    }

    sourceSets.nativeMain {
        kotlin {
            srcDir(".build/plugins/outputs/swiftjavaextractkotlinsampleapp/MySwiftLibrary/destination/JExtractSwiftPlugin/src/generated")
        }
    }
}
