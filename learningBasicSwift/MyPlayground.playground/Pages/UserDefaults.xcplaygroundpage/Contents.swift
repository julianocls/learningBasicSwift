//: [Previous](@previous)

import Foundation
import CoreGraphics


let defaults = UserDefaults.standard
defaults.set(25, forKey: "Age")
defaults.set(true, forKey: "UserTouchID")
defaults.set(CGFloat.pi, forKey: "Pi")

defaults.set("Juliano Santos", forKey: "name")
defaults.set(Date(), forKey: "LastRun")

let array = ["Hello", "World"]
defaults.set(array, forKey: "SaveArray")

let dic = ["Name": "Juliano", "Coutry": "Brazil"]
defaults.set(dic, forKey: "SaveDict")

// reading...
let array_ = defaults.object(forKey: "SaveArray") as? [String] ?? [String]()

let dic_ = defaults.object(forKey: "SaveDict") as? [String: String] ?? [String: String]()

let name = defaults.object(forKey: "name") as? String ?? String()

let pi = defaults.object(forKey: "Pi") as? CGFloat ?? CGFloat()
