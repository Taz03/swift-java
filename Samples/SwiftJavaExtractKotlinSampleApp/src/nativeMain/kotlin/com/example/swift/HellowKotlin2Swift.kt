package com.example.swift

import kotlinx.cinterop.ExperimentalForeignApi
import platform.posix.RTLD_LAZY
import platform.posix.dlopen
import platform.posix.dlsym

@OptIn(ExperimentalForeignApi::class)
fun main() {
    println("Hello from Kotlin to Swift!")

    val handle = dlopen(
        __path = "MySwiftLibrary",
        __mode = RTLD_LAZY
    )
    val address = dlsym(
        __handle = handle,
        __symbol = "helloWorld"
    )
    println(address?.rawValue)

//    val mySwiftClass = MySwiftClass.init(6, 7)
//
//    globalBuffer()
//    globalCallMeRunnable {
//        println("Hello from Kotlin to Swift in a Runnable!")
//    }
}
