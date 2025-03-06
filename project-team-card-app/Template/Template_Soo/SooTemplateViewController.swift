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
        templateView.editButton.addTarget(self, action: #selector(goToCreateUser), for: .touchUpInside)
        templateView.deleteButton.addTarget(self, action: #selector(goToModifyUser), for: .touchUpInside)
        
        // 깃허브 탭 제스처 구현
        let gitButtonTapGesture = CustomTapGesture(target: self, action: #selector(openURLTapGeusture))
        gitButtonTapGesture.openURL = user.gitHubPathURL
        templateView.gitButton.addGestureRecognizer(gitButtonTapGesture)
        
        // 블로그 탭 제스처 구현
        let blogButtonTapGesture = CustomTapGesture(target: self, action: #selector(openURLTapGeusture))
        blogButtonTapGesture.openURL = user.blogPathURL
        templateView.blogButton.addGestureRecognizer(blogButtonTapGesture)
    }
    
    @objc private func goToCreateUser(){
        let nextVC = CreateUserCardViewController(type: .create)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func goToModifyUser(){
        let nextVC = CreateUserCardViewController(type: .modify(userId: "CEA20844-8180-4F35-873D-834283863213"))
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func openURLTapGeusture(_ gesture: CustomTapGesture){
        guard let openURL = gesture.openURL, let url = URL(string: openURL) else {return}
        UIApplication.shared.open(url)
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
