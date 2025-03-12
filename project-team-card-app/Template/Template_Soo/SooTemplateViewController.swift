//
//  SooTemplateViewController.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/4/25.
//

import UIKit
import SafariServices

class SooTemplateViewController: UIViewController {
    private lazy var templateView = SooTemplateView()
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = templateView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUserData()
//        setInfoData(user: user)
    }

    @objc private func openURLTapGeusture(_ gesture: CustomTapGesture){
        guard let openURL = gesture.openURL, let url = URL(string: openURL) else {return}
//        UIApplication.shared.open(url)
        let safariViewController = SFSafariViewController(url: url)
          present(safariViewController, animated: true, completion: nil)

    }
    
//    public func setInfoData(user: User) {
//        DispatchQueue.main.async {[weak self] in
//            self?.templateView.config(user: user)   
//        }
//    }
    
    // 유저 정보 불러오기
    public func fetchUserData(){
        Task {
            do {
                let user = try await UserAPIService.fetchUser(userId: userId)
                self.setGesture(user: user)
                DispatchQueue.main.async {[weak self] in
                    self?.templateView.config(user: user)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // 제스처 등록
    private func setGesture(user: User) {

        // 깃허브 탭 제스처 구현
        let gitButtonTapGesture = CustomTapGesture(target: self, action: #selector(openURLTapGeusture))
        gitButtonTapGesture.openURL = user.gitHubPathURL
        templateView.gitButton.addGestureRecognizer(gitButtonTapGesture)
        
        // 블로그 탭 제스처 구현
        let blogButtonTapGesture = CustomTapGesture(target: self, action: #selector(openURLTapGeusture))
        blogButtonTapGesture.openURL = user.blogPathURL
        templateView.blogButton.addGestureRecognizer(blogButtonTapGesture)
    }
}
