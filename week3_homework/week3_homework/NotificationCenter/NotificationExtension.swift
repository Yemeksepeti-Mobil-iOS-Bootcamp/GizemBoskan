
//MARK: -  Gönderilecek Data Kullanıcıdan Alınsın...

import Foundation

extension Notification.Name {
    //MARK: static keyword neden kullanırız. Örnek bir kullanım yapınız
    static let sendDataNotification = Notification.Name(rawValue: "sendData")
}
