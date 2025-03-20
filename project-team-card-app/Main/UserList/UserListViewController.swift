//
//  UserListViewController.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/6/25.
//

import UIKit

typealias VCDelete = UserListViewDelegate&CreateUserViewControllerDelegate

class UserListViewController: UIViewController, VCDelete{
    
    private let userListView = UserListView()
    
    // 유저 리스트 정보 가져오기
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUsers()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = userListView
        userListView.delegate = self
        setAction()
    }
    // 액션 설정
    private func setAction() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        userListView.addUserButton.addTarget(self, action: #selector(touchUpInsideAddUserButton), for: .touchUpInside)
    }
    // Add User 버튼 액션
    @objc private func touchUpInsideAddUserButton() {
        let nextVC = CreateUserCardViewController(type: .create)
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true)
    }
    // 유저 배열 가져오기
    private func fetchUsers() {
        Task {
            do {
                let users = try await UserAPIService.fetchUsers()
                
                DispatchQueue.main.async { [weak self] in
                    
                    self?.userListView.users = users
                    self?.userListView.collectionView.reloadData()
                    self?.view = self?.userListView
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    func didSelectUser(userId: String) {
        let detailVC = TemplateHeaderViewController(userId: userId)
        detailVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    func didSetUser() {
        fetchUsers()
        userListView.layoutIfNeeded()
    }
}

#Preview{
    UserListViewController()
}
