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

// MARK: - Week2_Q.3.
/**
 Şişe vurma oyununu kodlayınız.
 */
struct Player {
    var username: String = ""
    var score: Int = 0
}

enum BottleState: Int {
    case rolling = 0 // devrik
    case standingUp = 1 // ayakta
}

struct Bottle {
    var d : Double = 0.0 // position
    var delta : Double = 0.1 // kaplama uzaklığı
    var state: BottleState = .standingUp
}

struct Launcher {
    private let g = 10.0
    
    var teta = Double.random(in: 0...90) // yerleşim açısı
    var V = Double.random(in: 0...100) // fırlatma hızı m/s
    
    public func calculateRange() -> Double {
        let R = V*V*sin(2*teta)/g
        return R
    }
}

public class Game {
    var player: Player = Player()
    var launcher: Launcher = Launcher()
    var bottle: Bottle = Bottle()
    
    public init() {}
    public func setPlayerName(name: String) {
        player.username = name
    }
    
    public func setBottlePosition(d: Double, delta: Double) {
        if 0.0 > d || d > 1500.0 {
            print("Error! Please set the position between 0.0 - 1500.0")
            exit(0)
        } else{
            bottle.d = d
        }
        
        
        if 0.1 > delta || delta > 1.0 {
            print("Error! Please set the position between 0.1 - 1.0")
            exit(0)
        } else{
            bottle.delta = delta
        }
    }
    
    public func setBallFiringRange(_ teta: Double, _ V: Double) {
        if 0.0 > teta || teta > 90.0 {
            print("Error! Please set the angle (teta) between 0.0 - 90.0")
            exit(0)
        }else{
            launcher.teta = teta
        }
        if 0.0 > V || V > 100.0 {
            print("Error! Please set the Velocity (V) between 0.0 - 100.0")
            exit(0)
        } else{
            launcher.V = V
        }
    }
    
    public func fire() {
        let range = launcher.calculateRange()
        
        if (bottle.d - bottle.delta) <= range  && range <= (bottle.d + bottle.delta) {
            bottle.state = .rolling
            player.score += 1
            print("Congratz! You hit the bottle!")
        } else {
            bottle.state = .standingUp
            player.score -= 1
            print("Ooops! You missed the bottle!")
        }
        
        print("Player username: \(player.username), score: \(player.score)")
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
 
 Her ikisi de aynı görevi yapıyor olmasına rağmen, guard let ilk olarak koşulu değerlendirip, eğer uygun koşul sağlanmıyor ise baştan return yapar; if let ise else bloğuna gelene kadar return olacağı durumu çalıştırmaz bu nedenle kullanım amaçları istenen koşullara bağlı olarak daha okunabilir kod yazılmasını sağlamak kısmında farklı olabilir. Aynı görevi üstlenebilmelerine rağmen bazı koşullarda guard let yapısı, bazı koşullarda if let yapısı kodun tekrarlanmasını engelleyebilir.
 */


