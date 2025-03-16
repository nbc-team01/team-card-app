//
//  TabbarView.swift
//  project-team-card-app
//
//  Created by 양원식 on 3/6/25.
//

import UIKit

class TabBarView: UITabBarController,UITabBarControllerDelegate {
    
    private let homeView = UINavigationController(rootViewController: HomeViewController())
    private let cardView = UINavigationController(rootViewController: UserListViewController())
    var tabItemTag = 0
    
    init() {
        super.init(nibName: nil, bundle: nil)
        object_setClass(self.tabBar, CustomTabBar.self)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        configure()
        tabItemUpdate()
    }
    private func tabItemUpdate(){
        //원본 이미지대로 아이콘 사용
        homeView.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named:"Home")?.imageWithAlphaColor(alpha: tabItemTag == 0 ? 1.0:0.3)?.withRenderingMode(.alwaysOriginal),tag: 0)
        cardView.tabBarItem = UITabBarItem(title: "맴버카드", image: UIImage(named:"Member")?.imageWithAlphaColor(alpha: tabItemTag == 1 ? 1.0:0.3)?.withRenderingMode(.alwaysOriginal), tag: 1)
    }
    private func configure() {
        self.viewControllers = [homeView, cardView]
        self.tabBar.tintColor = .black
        self.tabBar.barTintColor = .white
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        tabItemTag = viewController.tabBarItem.tag
        tabItemUpdate()
    }
    
}

#Preview{
    TabBarView()
}




