//
//  SooTemplateViewController.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/4/25.
//

import UIKit

class SooTemplateViewController: UIViewController {
    private lazy var templateView = SooTemplateView()
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
        
        view = templateView
        setAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        fetchUserData()
        setInfoData(user: user)
    }

    private func setAction() {
        
        // 임시로 수정 / 생성 로직 테스트
        templateView.editButton.addTarget(self, action: #selector(goToCreateMember), for: .touchUpInside)
        templateView.deleteButton.addTarget(self, action: #selector(goToModifyMember), for: .touchUpInside)
    }
    
    @objc private func goToCreateMember(){
        let nextVC = CreateMemberCardViewController(type: .create)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func goToModifyMember(){
        let nextVC = CreateMemberCardViewController(type: .modify(userId: "CEA20844-8180-4F35-873D-834283863213"))
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    public func setInfoData(user: User) {
        DispatchQueue.main.async {[weak self] in
            self?.templateView.config(user: user)   
        }
    }
    
//    public func fetchUserData(){
//        Task {
//            do {
//                let user = try await UserAPIService.fetchUser(userId: userId)
//                DispatchQueue.main.async {[weak self] in
//                    self?.templateView.config(user: user)
//                }
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//    }
}
