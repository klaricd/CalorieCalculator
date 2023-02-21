//
//  TabBarViewController.swift
//  Calorie Counter
//
//  Created by David Klaric on 25.01.2023..
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var upperLineView: UIView!
        
        let spacing: CGFloat = 12

        override func viewDidLoad() {
            super.viewDidLoad()
            self.delegate = self
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                self.addTabbarIndicatorView(index: 0, isFirstTime: true)
            }
        }
        
        //Add tabbar item indicator uper line
        func addTabbarIndicatorView(index: Int, isFirstTime: Bool = false){
            guard let tabView = tabBar.items?[index].value(forKey: "view") as? UIView else {
                return
            }
            if !isFirstTime{
                upperLineView.removeFromSuperview()
            }
            upperLineView = UIView(frame: CGRect(x: tabView.frame.minX + spacing, y: tabView.frame.minY + 0.1, width: tabView.frame.size.width - spacing * 2, height: 3))
            upperLineView.backgroundColor = UIColor.systemBlue
            tabBar.addSubview(upperLineView)
        }

    }

    extension TabBarViewController: UITabBarControllerDelegate {
        func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
            addTabbarIndicatorView(index: self.selectedIndex)
        }
}
