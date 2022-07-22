import UIKit

var str = "Hello, playground"


let defaults = UserDefaults.standard

struct 
defaults.setValue(str, forKey: "key")

let res = defaults.string(forKey: "key")

print(res)
