import org.gradle.buildinit.plugins.internal.modifiers.Language
import utilities.registerJextractTask

plugins {
    kotlin("jvm") version "2.3.0"
    id("build-logic.java-application-conventions")
}

group = "com.example.swift"
version = "unspecified"

repositories {
    mavenCentral()
}

kotlin {
    jvmToolchain(25)
}

val jextract = registerJextractTask(language = Language.KOTLIN)

sourceSets {
    main {
        kotlin {
            srcDir(jextract)
        }
    }
}

tasks.build {
    dependsOn(jextract)
}

registerCleanSwift()

dependencies {
    testImplementation(kotlin("test"))
}

tasks.test {
    useJUnitPlatform()
}
