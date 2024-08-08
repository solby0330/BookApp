//
//  TapBarController.swift
//  BookApp_240802
//
//  Created by 김솔비 on 8/5/24.
//

import UIKit

class TapBarController: UITabBarController {
  
  lazy var homeController: UINavigationController = {
    let controller = HomeController()
    let navigationController = UINavigationController(rootViewController: controller)
    navigationController.tabBarItem.title = "Home"
//    navigationController.tabBarItem.image = UIImage(systemName: "")
    return navigationController
  }()
  
  lazy var addCartController: UINavigationController = {
    let controller = AddCartController()
    let navigationController = UINavigationController(rootViewController: controller)
    navigationController.tabBarItem.title = "Cart"
//    navigationController.tabBarItem.image = UIImage(systemName: "")
    return navigationController
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewControllers = [homeController, addCartController]
  }
}

