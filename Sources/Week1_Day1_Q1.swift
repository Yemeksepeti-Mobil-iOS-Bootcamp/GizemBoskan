import Foundation

public class Week1_Day1_Q1 {
    // MARK: - Q.1.
    /**
     Elimizde sadece harflerden oluşan (noktalama işareti veya sayılar yok) uzun karakterler olsun. Bu karekterlerin içinde bazı hafrflerin tekrar edeceğini düşünün. Mesela 'a ' harfi 20 farklı yerde geçiyor. Bir fonksiyon ile verilen parametre değerine eşit ve daha fazla bulunan harfler silinecektir. Sonra geriye kalan string ekrana yazdırılacaktır. Not boşluklar sayılmayacak:)
     Örnek string: "aaba kouq bux"
     Tekrar sayısı 2 verildiğinde : a,b,u silinmeli ve ekrana "koq x" yazmalı
     Tekrar sayısı 3 verildiğinde : a silinmeli ve ekrana "b kouq bux"
     tekrar sayısı 4 verildiğinde  :  hiç bir harf silinmemeli aynı stringi yazmalı
     
     Not: String ve tekrar sayısını parametre olarak alsın. func (myString, count)
     */
    
    public static func findString(myString: String, count: Int) -> String{
        
        var dict = [Character: Int]()
        var resultedString = myString
        
        for character in resultedString.replacingOccurrences(of: " ", with: "") {
            let key = character
            let currentCounterValue = (dict[key] ?? 0) + 1
            dict.updateValue(currentCounterValue, forKey: key)
        }
        
        for item in dict {
            if item.value >= count {
                resultedString = resultedString.replacingOccurrences(of: String(item.key), with: "")
            }
        }
        
        return resultedString
    }
}
