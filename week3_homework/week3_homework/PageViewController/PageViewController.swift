
//  week3_homework
//
//  Created by Gizem Boskan on 9.07.2021.

//MARK: - PageControl ekleyerek bir onboarding ekranı yapınız..

import UIKit

class PageViewController: UIViewController {
    // MARK: - Properties
    var controllers = [UIViewController]()
    
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = UIViewController()
        vc1.view.addSubview(UIImageView(image: UIImage(imageLiteralResourceName: "photo1")))
        controllers.append(vc1)
        
        let vc2 = UIViewController()
        vc2.view.addSubview(UIImageView(image: UIImage(imageLiteralResourceName: "photo2")))
        controllers.append(vc2)
        
        let vc3 = UIViewController()
        vc3.view.addSubview(UIImageView(image: UIImage(imageLiteralResourceName: "photo3")))
        controllers.append(vc3)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.pageVC()
    }
    
    // MARK: - Helpers
    func pageVC() {
        guard let first = controllers.first else { return }
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        vc.delegate = self
        vc.dataSource = self
        vc.setViewControllers([first], direction: .forward, animated: true, completion: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
// MARK: - Page View Controller Delegate and Data Source

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?{
        
        guard let index = controllers.firstIndex(of: viewController), index > 0 else { return nil }
        let prev = index - 1
        return controllers[prev]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = controllers.firstIndex(of: viewController), index < (controllers.count - 1) else { return nil }
        let next = index + 1
        return controllers[next]
    }
    
    func presentationCount(for _: UIPageViewController) -> Int {
        return controllers.count
    }
    
    func presentationIndex(for _: UIPageViewController) -> Int {
        guard let firstViewController = controllers.first,
              let firstViewControllerIndex = controllers.firstIndex(of: firstViewController) else {
            return 0
        }
        return firstViewControllerIndex
    }
}


