//
//  ViewController.swift
//  week3_homework
//
//  Created by Gizem Boskan on 28.07.2021.
//

import UIKit

class TabBarController : UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let prominentTabBar = self.tabBar as! ProminentTabBar
        prominentTabBar.prominentButtonCallback = prominentTabTaped
    }
    func prominentTabTaped() {
        selectedIndex = (tabBar.items?.count ?? 0)/2
    }

}

