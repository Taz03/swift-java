package com.example.swift

import kotlinx.cinterop.CFunction
import kotlinx.cinterop.ExperimentalForeignApi
import kotlinx.cinterop.asStableRef
import kotlinx.cinterop.invoke
import kotlinx.cinterop.reinterpret
import kotlinx.cinterop.toKString
import platform.posix.RTLD_NOW
import platform.posix.dlerror
import platform.posix.dlopen
import platform.posix.dlsym

@OptIn(ExperimentalForeignApi::class)
fun main() {
    println("Hello from Kotlin to Swift!")

    val handle = dlopen(
        __path = ".build/arm64-apple-macosx/debug/libMySwiftLibrary.dylib",
        __mode = RTLD_NOW
    )
    handle ?: println(dlerror()?.toKString())
    println(handle?.rawValue)

    val address = dlsym(
        __handle = handle,
        __symbol = $$"$s14MySwiftLibrary13globalMakeIntSiyF"
    )
    address ?: println(dlerror()?.toKString())
    println(address?.rawValue)

    val func = address?.reinterpret<CFunction<() -> Int>>()
    println(func?.invoke())

//    val mySwiftClass = MySwiftClass.init(6, 7)
//
//    globalBuffer()
//    globalCallMeRunnable {
//        println("Hello from Kotlin to Swift in a Runnable!")
//    }
}
