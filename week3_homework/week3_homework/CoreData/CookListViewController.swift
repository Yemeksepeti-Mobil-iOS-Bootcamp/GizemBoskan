   
   //MARK: - Resmi cell de gösteriniz.
   
   //MARK: - Silme işlemi yapınız. Direk silmeden ziyade kullanıcıya uyarı gösterip silmek istediğinizden emin misiniz uyarısı ile işlemi yapınız.
   
   import UIKit
   import CoreData
   
   class CookListViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    var cookNames = [String]()
    
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
        cookNames.removeAll()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cook")
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    guard let name = result.value(forKey: "name") as? String else { return }
                    cookNames.append(name)
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
        cookNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cookCell", for: indexPath)
        
        cell.textLabel?.text = cookNames[indexPath.row]
        
        return cell
    }
   }
