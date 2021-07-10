
//  week3_homework
//
//  Created by Gizem Boskan on 9.07.2021.

//MARK: -  Gönderilecek Data Kullanıcıdan Alınsın...

import UIKit

class NotificationListenerVC: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var notificationDataLbl: UILabel!
    @IBOutlet weak var listenerImg: UIImageView!
    
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationCenter: NotificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(handleData(notification:)), name: .sendDataNotification, object: nil)
    }
    
    // MARK: - Helpers
    @objc func changeImage() {
        self.listenerImg.image = UIImage(named: "photo-4")
    }
    
    @objc func handleData(notification: Notification) {
        
        if let data = notification.userInfo?["data"] as? String {
            notificationDataLbl.text = data
        }
    }
    
}
