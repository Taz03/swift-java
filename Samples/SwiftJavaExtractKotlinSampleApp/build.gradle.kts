import org.gradle.buildinit.plugins.internal.modifiers.Language
import utilities.registerJextractTask

plugins {
    alias(libs.plugins.kotlin.multiplatform)
    alias(libs.plugins.kotlinx.serialization)
    id("build-logic.java-application-conventions")
}

group = "com.example.swift"
version = "unspecified"

repositories {
    mavenCentral()
}

val jextract = registerJextractTask(language = Language.KOTLIN)

kotlin {
    macosArm64 {
        binaries.executable {
            entryPoint = "com.example.swift.main"
        }
    }

    sourceSets.nativeMain {
        kotlin {
            srcDir(jextract)
        }
    }
}

registerCleanSwift()

tasks.build {
    dependsOn(jextract)
}

/*
sourceSets {
    main {
        kotlin {
            srcDir(jextract)
        }
    }
}

dependencies {
    testImplementation(kotlin("test"))
}

tasks.test {
    useJUnitPlatform()
}
*/
