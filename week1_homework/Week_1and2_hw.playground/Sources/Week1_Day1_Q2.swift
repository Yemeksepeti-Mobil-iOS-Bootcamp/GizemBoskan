import Foundation

public class Week1_Day1_Q2 {
    /**
     Elimizde uzun bir cümle olsun, Bazı kelimeler tekrar edecek bir cümle düşünün. İstediğimiz ise, hangi kelimeden kaç tane kullanıldığını bulmanız.
     string = "merhaba nasılsınız . iyiyim siz nasılsınız . ben de iyiyim. "
     */

    public static func countWords(sentence: String) -> [String: Int]{

        var words : [String] = []
        sentence.enumerateSubstrings(in: sentence.startIndex..<sentence.endIndex,
                                   options: .byWords) {
            (substring, _, _, _) -> () in
            words.append(substring!)
        }
        var wordCount = [String: Int]()
        for word in words {
            let key2 = word

            let currentCounterValue = (wordCount[key2] ?? 0) + 1
            wordCount.updateValue(currentCounterValue, forKey: key2)

        }
        return wordCount
    }
}
