import Cocoa

enum sqrtError: Error {
    case outOfBounds, noRoot
}

func mySqrt(_ number: Int) throws -> Int {
    if number < 1 || number > 10_000 {
        throw sqrtError.outOfBounds
    }
    
    var root = 0
    for i in 1...100 {
        let square = i * i
        if square == number {
            root = i
            break
        } else if square > number {
            break
        }
    }
    
    if root == 0 {
        throw sqrtError.noRoot
    }
    
    return root
}

do {
    let result = try mySqrt(101)
    print(result)
}
catch sqrtError.outOfBounds {
    print("Use a number between 1 and 10,000")
}
catch sqrtError.noRoot {
    print("No square root found.")
}
catch {
    print("An error ocurred. \(error)")
}



