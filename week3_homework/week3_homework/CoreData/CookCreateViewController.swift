 
 //  week3_homework
 //
 //  Created by Gizem Boskan on 9.07.2021.
 
 //MARK: - Resmi cell de gösteriniz.
 
 //MARK: - Silme işlemi yapınız. Direk silmeden ziyade kullanıcıya uyarı gösterip silmek istediğinizden emin misiniz uyarısı ile işlemi yapınız.
 
 import UIKit
 import CoreData
 
 class CookCreateViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    // MARK: - Properties
    var cookLists = [CookModel]()
    @IBOutlet weak var cookImage: UIImageView!
    @IBOutlet weak var cookName: UITextField!
    
    
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        cookImage.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosePhoto))
        cookImage.addGestureRecognizer(tapRecognizer)
    }
    // MARK: - Helpers
    @objc func choosePhoto() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        cookImage.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func insertCook(_ sender: Any) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        let newCook = NSEntityDescription.insertNewObject(forEntityName: "Cook", into: context)
        newCook.setValue(cookName.text, forKey: "name")
        let imageData = cookImage.image?.jpegData(compressionQuality: 0.5)
        newCook.setValue(imageData, forKey: "image")
        newCook.setValue(UUID(), forKey: "id")
        
        do {
            try context.save()
        } catch  {
            print("Could not be saved!")
        }
        
        self.navigationController?.popViewController(animated: true)
    }
 }
