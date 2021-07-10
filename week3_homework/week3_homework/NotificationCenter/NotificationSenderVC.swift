 
 //  week3_homework
 //
 //  Created by Gizem Boskan on 9.07.2021.
 
 //MARK: -  Gönderilecek Data Kullanıcıdan Alınsın...
 
 import UIKit
 
 class NotificationSenderVC: UIViewController {
    // MARK: - Properties
    var notificationData: [String: Any] = [:]
    
    @IBOutlet var sendNotificationTextField: UITextField!
    
    
    // MARK: - Helpers
    @IBAction func sendNotificationBtn(_ sender: Any) {
        
        notificationData["data"] = sendNotificationTextField.text
        
        NotificationCenter.default.post(name: .sendDataNotification, object: nil, userInfo: notificationData)
        dismiss(animated: true, completion: nil)
    }
 }
