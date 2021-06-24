import Foundation

public class Week1_Day2_Q5 {
    // MARK: - Q.5.Smallest multiple

    //  2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder. What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

    public static func smallestMultiple(of number: Int) -> Int {
        var resultedProduct = 1
        for num2 in 1...number {
            resultedProduct = (resultedProduct * num2) / findDivision(resultedProduct, num2)
        }
        return resultedProduct
    }
    private static func findDivision(_ num1: Int, _ num2: Int) -> Int {
        
        let retainValue = num1 % num2
        
        if retainValue != 0 {
            
            return findDivision(num2, retainValue)
            
        } else {
            return num2
        }
    }
}
