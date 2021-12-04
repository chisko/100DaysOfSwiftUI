import Cocoa


func randomElement(from elements: [Int]?) -> Int {
    return elements?.randomElement() ?? Int.random(in: 1...100)
}

let numbers: [Int]? = nil//[1, 3, 4, 5, 7, 8, 10]
print(randomElement(from: numbers))
