import Cocoa

func areLettersIdentical(string1: String, string2: String) -> Bool {
    return string1.lowercased().sorted() == string2.lowercased().sorted()
}

areLettersIdentical(string1: "Fco", string2: "CFO")


func pythagoras(a: Double, b: Double) -> Double {
    let input = a * a + b * b
    let root = sqrt(input)
    return root
}

let c = pythagoras(a: 3, b: 4)






func getUser() -> (firstName: String, lastName: String) {
    (firstName: "Francisco", lastName: "Ruiz")
}

let (fName, lName) = getUser()
print("Hi, \(fName) \(lName)")
