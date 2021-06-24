import Foundation

public class Week1_Day2_Q4 {
    // MARK: - Q.4.Largest palindrome product

    //  A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99. Find the largest palindrome made from the product of two 3-digit numbers.

    public static func largestPalindromeOf3DigitNumber() -> Int {
        var product = 0
        var result = 0
        for x in stride(from: 999, to: 100, by: -1) {
            
            for y in stride(from: 999, to: 100, by: -1){
                
                product = x*y
                
                let productString = String(product)
                let revProductString = String(productString.reversed())
                
                if productString == revProductString {
                    
                    if product > result {
                        result = product
                        break
                    }
                }
                
            }
        }
        
        return result
    }
}
