//: Playground - noun: a place where people can play

/*
 This is a longer
 comment spanning
 multiple lines.
 */

import UIKit
import Foundation

// Variables & Constantes
var str = "Hello, playground"
var str2: String = "Hello, playground"

str = "Str is a variable"
let cst = "This a a constant"

var 👍🏻 = ""


// Booléens
let myBool = true
var notTrue = false
notTrue = true

// Numbers
let a : Int = 2
let b : Float = 2.65
let c = Float(a) * b

// Strings
let company = "Coaxys"
let companyInit = String("Coaxys")
let chars = company.characters

// Collections
let myArray = [1, 2, 3, 4, 5]
let myDictionary = ["One": 1, "Two": 2, "Three": 3]
let mySet = Set(["One", "Two", "Three", "Four", "Five"])

var arr1 : [Int] = []
arr1.append(2)

let arr2 : [Any] = [1, 2, 3, "Four", "Five"]

// Classes
class Boat {
    
    var speed: Float = 0
    var lifeboats: Int = 2
    
    func deployLifeboats() {
        // ...
    }
    
}

var boat = Boat()

boat.speed = 10.5
boat.lifeboats += 1

boat.deployLifeboats()


// Structure
struct Ship {
    
    var speed: Float = 0
    var lifeboats: Int = 2
    
    func deployLifeboats() {
        // ...
    }
    
}


// Classe != Structure
var boat1 = Boat()
boat1.speed = 11.0

var boat2 = boat1
boat2.speed = 15.0

boat1.speed
boat2.speed

var ship1 = Ship()
ship1.speed = 11.0

var ship2 = ship1
ship2.speed = 15.0

ship1.speed
ship2.speed

class Speedboat : Boat {
    
}

var speedboat = Speedboat()

speedboat.speed = 100.0
speedboat.lifeboats = 0
speedboat.deployLifeboats()


// Optionnals

var optionalStr: String?
optionalStr = "Test"
print(optionalStr!)

if optionalStr != nil {
    print(optionalStr!)
} else {
    print("optionalStr has no value")
}

if let strConst = optionalStr {
    print(strConst)
} else {
    print("optionalStr has no value")
}


// Fonctions
func printHelloWorld() {
    print("Hello World!")
}
printHelloWorld()

func printMessage(message: String) {
    print(message)
}
printMessage(message: "Hello ! 👋🏼")

func printMessage(_ message: String, time: Int = 3) {
    for _ in 1...time {
        print(message)
    }
}
printMessage("Hello multiple ! 👋🏼", time: 5)


func formatDate(date: Date, format: String = "YY/MM/dd") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: date)
}
let dateAsString = formatDate(date: Date())

// Closures
let closure = {(a: Int) -> Int in
    return a + 1
}

var states = ["California", "New York", "Texas", "Alaska"]
let abbreviatedStates = states.map({ (state: String) -> String in
    let index = state.index(state.startIndex, offsetBy: 2)
    return state.substring(to: index).uppercased()
})
let abbreviations = states.map({ state in state.substring(to: state.index(state.startIndex, offsetBy: 2)).uppercased() })
print(abbreviatedStates, abbreviations)

let abbreviationsTrailing = states.map { $0.substring(to: $0.index($0.startIndex, offsetBy: 2)).uppercased() }
print(abbreviationsTrailing)


// Protocoles
protocol Repairable {
    var time: Float { get }
    var cost: Float { get set }
    
    func repair()
}

class Boat2: Repairable {
    
    var speed: Float = 0
    var lifeboats: Int = 2
    
    var time: Float = 10.0
    var cost: Float = 100.0
    
    func deployLifeboats() {
        // ...
    }
    
    func repair() {
        // ...
    }
    
}