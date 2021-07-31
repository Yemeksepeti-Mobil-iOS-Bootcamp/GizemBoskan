//
//  ViewController.swift
//  BusTicket
//
//  Created by Gizem Boskan on 27.07.2021.
//

import UIKit

class BuyViewController: UIViewController {
    
    let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var surnameTextfield: UITextField!
    @IBOutlet weak var ticketLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround() 
        // Do any additional setup after loading the view.
        ticketLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 3)

        ticketLabel.text = TicketManager.shared.ticket.print()
        priceLabel.text = "Fiyat: \(String(describing: (150...200).randomElement()!)) TL"
        
        
        // Position Activity Indicator in the center of the main view
        spinner.center = view.center
        spinner.color = .red
        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        spinner.hidesWhenStopped = false
        
        // Start Activity Indicator
        spinner.startAnimating()
        
        // Call stopAnimating() when need to stop activity indicator
        //myActivityIndicator.stopAnimating()
        view.addSubview(spinner)
        
        nameTextfield.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        
        surnameTextfield.addTarget(self, action: #selector(textFieldDidChangeSurname), for: UIControl.Event.editingChanged)
        
        TicketManager.shared.ticket.passenger.passengerId = (1...100).randomElement() ?? 0
    }
    
    @objc func textFieldDidChange() {
        TicketManager.shared.ticket.passenger.passengerName = nameTextfield.text ?? "İsimsiz"
        ticketLabel.text = TicketManager.shared.ticket.print()
    }
    
    @objc func textFieldDidChangeSurname() {
        TicketManager.shared.ticket.passenger.passengerSurname = surnameTextfield.text ?? "İsimsiz"
        ticketLabel.text = TicketManager.shared.ticket.print()
    }
    
    @IBAction func buyAction(_ sender: UIButton) {
        if let name = nameTextfield.text?.isEmpty, let surname = surnameTextfield.text?.isEmpty, name || surname {
            let alert = UIAlertController(title: "HATA", message: "Lütfen isim-soyisim giriniz", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .cancel, handler: { _ in
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        spinner.startAnimating()
        sleep(3)
        spinner.stopAnimating()
        if !TicketManager.shared.ticket.compareIsTaken(takenSeatNumbers: BusSeatManager.shared.takenSeatNumbers) {
            let alert = UIAlertController(title: "Tebrikler", message: "İşleminiz başarı ile sonuçlandı.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .destructive, handler: { _ in
                BusSeatManager.shared.generateBoughtSeats()
                TicketManager.shared.reset()
                self.navigationController?.popToRootViewController(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
