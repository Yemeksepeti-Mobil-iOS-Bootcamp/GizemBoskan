   
   //MARK: - Resmi cell de gösteriniz.
   
   //MARK: - Silme işlemi yapınız. Direk silmeden ziyade kullanıcıya uyarı gösterip silmek istediğinizden emin misiniz uyarısı ile işlemi yapınız.
   
   import UIKit
   import CoreData
   
   class CookListViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    var cookLists = [CookModel]()
    var cookName: String?
    var cookImage: UIImage? = nil
    
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCooks()
    }
    // MARK: - Helpers
    private func getCooks() {
        cookLists.removeAll()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cook")
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    
                    guard let name = result.value(forKey: "name") as? String else { return }
                    guard let imageData = result.value(forKey: "image") as? Data, let img = UIImage(data: imageData)  else { return }
                    guard let id = result.value(forKey: "id") as? UUID else { return }
                    self.cookLists.append(CookModel(id: id, cookName: name, cookImage: img))
                    
                    //                    // Add it to the memes array on the Application Delegate
                    //                    (UIApplication.shared.delegate as! AppDelegate).cookLists.append(cookList)
                }
                self.tableView.reloadData()
            } else {
                //TODO:
            }
        } catch {
            print("Error")
        }
    }
   }
   
   // MARK: - TableView Delegate and Data Source
   extension CookListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cookLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cookCell", for: indexPath)
        
        let cookList = cookLists[(indexPath as NSIndexPath).row]
        cell.imageView?.image = cookList.cookImage
        cell.textLabel?.text = cookList.cookName
        cell.imageView?.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView?.layer.borderWidth = 2
        cell.imageView?.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let ac = UIAlertController(title: "Delete?", message: "Do you want to delete this item?", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Delete!" , style: .destructive, handler: { _ in
                self.deleteData(index: indexPath.row)
            }))
            present(ac, animated: true)
        }
    }
    func deleteData(index: Int){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Cook")
        
        fetchRequest.predicate = NSPredicate(format: "id = %@", "\(cookLists[index].id)")
        do
        {
            let fetchedResults =  try context.fetch(fetchRequest) as? [NSManagedObject]
            
            for entity in fetchedResults! {
                
                context.delete(entity)
                cookLists.remove(at: index)
                tableView.reloadData()
            }
            try context.save()
        }
        catch _ {
            print("Could not delete")
            
        }
    }
   }
