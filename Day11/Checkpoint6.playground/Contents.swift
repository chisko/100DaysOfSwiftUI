import Cocoa

struct Car {
    let model: String
    let numberOfSeats: Int
    let maximumGears: Int
    private(set) var currentGear: Int = 0
    
    init(model: String, numberOfSeats: Int, maximumGears: Int) {
        self.model = model
        self.numberOfSeats = numberOfSeats
        self.maximumGears = maximumGears
    }
    
    mutating func changeGear(difference: Int) {
        currentGear = currentGear + difference

        if currentGear < 1 {
            currentGear = 1
        } else if currentGear > maximumGears {
            currentGear = maximumGears
        }
    }
}

var audi = Car(model: "2019 Audi A3", numberOfSeats: 5, maximumGears: 6)
print(audi.currentGear)
audi.changeGear(difference: 3)
audi.changeGear(difference: 2)
print(audi.currentGear)
audi.changeGear(difference: 5)
print(audi.currentGear)
