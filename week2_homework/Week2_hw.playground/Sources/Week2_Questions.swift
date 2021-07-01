import Foundation

// MARK: - Week2_Q1.
/**
 Girilen bir sayının asal olup olmadığını bulan bir extension yazınız.
 */
extension Int {
    public var isPrimeNumber: Bool {
        if self <= 0  || self == 1 {
            return false
        }
        if self <= 3 {
            return true
        }
        let doubleSelf = Double(self)
        let root = Int(doubleSelf.squareRoot())
        for i in 2...root {
            if self % i == 0 {
                return false
            }
        }
        return true
    }
}


public class Week2_Q2 {
    // MARK: - Q.2.
    /**
     İki parametreli ve farklı tipli bir generic örneği yazınız. (T,U)
     */
    public static func someFunction<T: Numeric, U: CustomStringConvertible>(someT: T, someU: U) {
        // function body goes here
        print("I'm some numeric: \(someT)")
        print("I'm some String Protocol: \(someU)")
    }
}


public class Week2_Q3 {
    // MARK: - Q.3.
    /**
     Şişe vurma oyununu kodlayınız.
     */
    public static func x() {
        
    }
}


public class Week2_Q4 {
    // MARK: - Q.4.
    /**
     Project Euler - 6 (Sum square difference)
     
     The sum of the squares of the first ten natural numbers is,
     1^2 + 2^2 + ... + 10^2 = 385
     The square of the sum of the first ten natural numbers is,
     (1 + 2 + ... + 10)^2 = 55^2 = 3025
     Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025 - 385 = 2640.
     Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.
     */
    public static func sumSquareDifference(x: Int) -> Int{
        var sumOfSquares = 0
        var squareOfSum = 0
        for i in 1...x {
            var squares = 0
            squares = i*i
            sumOfSquares += squares
            squareOfSum += i
        }
        squareOfSum *= squareOfSum
        
        return (squareOfSum - sumOfSquares)
    }
}

public class Week2_Q5 {
    // MARK: - Q.5.
    /**
     Project Euler - 7 (10001st prime)
     
     By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
     What is the 10001st prime number?
     */
    public static func orderOfPrime(order: Int) -> Int{
        var x = 0
        var result = 0
        if order == 1 {
            return 1
        }
        for i in 1... {
            if i.isPrimeNumber {
                x += 1
                if x == order{
                    result = i
                    break
                }
            }
        }
        return result
    }
}


// MARK: - Week2_Q6.
/**
 if let - guard let kullanım tercihi neye göre belirlenir?
 */


