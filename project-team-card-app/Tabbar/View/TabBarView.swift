//
//  TabbarView.swift
//  project-team-card-app
//
//  Created by 양원식 on 3/6/25.
//

import UIKit

//MARK: 탭바 뷰
class TabBarView: UITabBarController,UITabBarControllerDelegate {
    
    //MARK: 홈화면
    private let homeView = UINavigationController(rootViewController: HomeViewController())
    //MARK: 카드화면
    private let cardView = UINavigationController(rootViewController: UserListViewController())
    //MARK: 아이템 태그
    var tabItemTag = 0
    
    init() {
        super.init(nibName: nil, bundle: nil)
        //런타임 중 타입 캐스팅
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
    //MARK: 탭바 아이템 업데이트
    private func tabItemUpdate(){
        homeView.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named:"Home")?.imageWithAlphaColor(alpha: tabItemTag == 0 ? 1.0:0.3)?.withRenderingMode(.alwaysOriginal),tag: 0)
        cardView.tabBarItem = UITabBarItem(title: "맴버카드", image: UIImage(named:"Member")?.imageWithAlphaColor(alpha: tabItemTag == 1 ? 1.0:0.3)?.withRenderingMode(.alwaysOriginal), tag: 1)
    }
    //MARK: 탭바 속성 설정
    private func configure() {
        self.viewControllers = [homeView, cardView]
        self.tabBar.tintColor = .black
        self.tabBar.barTintColor = .white
    }
    //MARK: 탭바 선택 이벤트
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        tabItemTag = viewController.tabBarItem.tag
        tabItemUpdate()
    }
}

#Preview{
    TabBarView()
}




