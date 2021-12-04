import Cocoa

class Animal {
    var legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    init() {
        super.init(legs: 4)
    }
    
    func speak() {
        print("bark!")
    }
}

class Corgi: Dog {
    override func speak() {
        print("corgi bark!")
    }
}

class Poodle: Dog {
    override func speak() {
        print("poodle bark!")
    }
}

class Cat: Animal {
    var isTame: Bool
    
    init(isTame: Bool) {
        self.isTame = isTame
        super.init(legs: 4)
    }
    
    func speak() {
        print("meaow!")
    }
}

class Persian: Cat {
    override func speak() {
        print("persian meaow!")
    }
}

class Lion: Cat {
    override func speak() {
        print("roar!")
    }
}

let dog = Dog()
dog.speak()
let corgi = Corgi()
corgi.speak()
let poodle = Poodle()
poodle.speak()
let cat = Cat(isTame: true)
cat.speak()
let persian = Persian(isTame: true)
persian.speak()
let lion = Lion(isTame: false)
lion.speak()
