   
   //MARK: - Resmi cell de gösteriniz.
   
   //MARK: - Silme işlemi yapınız. Direk silmeden ziyade kullanıcıya uyarı gösterip silmek istediğinizden emin misiniz uyarısı ile işlemi yapınız.
   
   import UIKit
   import CoreData
   
   class CookCreateViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    // MARK: - Properties
    @IBOutlet weak var cookImage: UIImageView!
    @IBOutlet weak var cookName: UITextField!
    
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
        
        do {
            try context.save()
        } catch  {
            print("Kaydedilemedi...")
        }
        
        self.navigationController?.popViewController(animated: true)
    }
   }
