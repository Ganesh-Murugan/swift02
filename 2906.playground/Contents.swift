protocol Pet {
    var name: String {get}
    var food: String {get set}
}

struct Cat: Pet {
    var name: String
    var food: String
    var someCatProp: String
}

struct Dog: Pet {
    var name: String
    var food: String
    var someDogProp: String
}


struct PetViewModel {
    static let pets: [Pet] = [
        Cat(name: "meow", food: "fish", someCatProp: "SomeCatProp"),
        Dog(name: "Boow", food: "Meat", someDogProp: "SomeDogProp")
    ]
}
print((PetViewModel.pets[0] as! Cat).someCatProp)
print(PetViewModel.pets[1])

