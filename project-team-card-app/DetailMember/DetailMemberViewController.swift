//
//  DetailMemberViewController.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/6/25.
//

import UIKit

class DetailMemberViewController: UIViewController {
    private var childVCs: [UIViewController] = []
    private var currentChildVC: UIViewController?
    private let user: User
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildViewControllers()
    }
    
    private func setupChildViewControllers() {
        let wonsikTemplateVC = WonsikTemplateViewController() // 원식님
        let sooTemplateVC = SooTemplateViewController(user: user) // 수현
        let hakyungTemplateVC = HakyungTemplateViewController() // 하경님
        
        childVCs = [wonsikTemplateVC, sooTemplateVC, hakyungTemplateVC]
        
        // 초기 선택된 뷰 컨트롤러 추가
        switchChildViewControllers(to: childVCs[0])
    }
    
    // VC 스위치
    private func switchChildViewControllers(to newVC: UIViewController){
        // 현재 자식 뷰 컨트롤러 제거
        if let currentVC = currentChildVC {
             currentVC.willMove(toParent: nil)
             currentVC.view.removeFromSuperview()
             currentVC.removeFromParent()
         }
        
        // 새로운 뷰 컨트롤러 추가
        addChild(newVC)
//        newVC.view.frame = containerView.bounds
//        newVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        containerView.addSubview(newVC.view)
        newVC.didMove(toParent: self)
        
        currentChildVC = newVC
    }
}
