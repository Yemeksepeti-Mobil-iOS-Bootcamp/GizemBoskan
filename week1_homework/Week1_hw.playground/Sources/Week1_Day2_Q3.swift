import Foundation

public class Week1_Day2_Q3 {
    // MARK: -  Q.3. Largest prime factor

    //  The prime factors of 13195 are 5, 7, 13 and 29. What is the largest prime factor of the number 600851475143 ?
    
    public static func largestPrimeFactor(of number: Int) -> Int {
        var number = number
        var maxPrimeFactor: Int = 1
        for i in 2...number {
            while number % i == 0 {
                number /= i
                maxPrimeFactor = i
            }
        }
        return maxPrimeFactor
    }
}
