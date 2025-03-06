//
//  MainViewController.swift
//  project-team-card-app
//
//  Created by 양원식 on 3/6/25.
//

import UIKit
import SnapKit

// MARK: - Main View Controller (Handles Home & Card Views)
class MainViewController: UIViewController {
    // 홈 뷰와 카드 뷰 인스턴스를 생성
    private let homeView = HomeViewController()
    private let cardView = UINavigationController(rootViewController: UserListViewController())
    private let tabBarView = CustomTabBarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        showHomeView() // 앱 실행 시 홈 뷰를 먼저 표시
    }
    
    // 디테일 뷰 이동 시 탭바 숨기기
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("MainVC - willDisAppear")
        tabBarView.isHidden = true
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        addChild(homeView)
        addChild(cardView)
        
        view.addSubview(homeView.view)
        view.addSubview(cardView.view)
        view.addSubview(tabBarView)
        
        homeView.view.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(tabBarView.snp.top)
        }
        
        cardView.view.snp.makeConstraints { make in
            make.edges.equalTo(homeView.view)
        }
        
        tabBarView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        
        // 탭바에서 버튼이 선택될 때 실행되는 콜백
        tabBarView.onTabSelected = { [weak self] selectedIndex in
            self?.switchView(to: selectedIndex)
        }
    }
    
    // 선택된 탭에 따라 화면을 변경하는 함수
    private func switchView(to index: Int) {
        homeView.view.isHidden = index != 0
        cardView.view.isHidden = index != 1
    }
    
    // 앱 실행 시 홈 뷰가 보이도록 설정
    private func showHomeView() {
        switchView(to: 0)
    }
    
    // 탭바 hidden처리
    public func setTabBar(isHidden: Bool) {
        self.tabBarView.isHidden = isHidden
    }
}
