package com.example.swift

fun main() {
    println("Hello from Kotlin to Swift!")

    val mySwiftClass = MySwiftClass.init(6, 7)

    globalBuffer()
    globalCallMeRunnable {
        println("Hello from Kotlin to Swift in a Runnable!")
    }
}
