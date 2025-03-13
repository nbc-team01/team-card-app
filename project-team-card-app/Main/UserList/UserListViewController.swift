//
//  UserListViewController.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/6/25.
//

import UIKit

class UserListViewController: UIViewController {
    private let userListView = UserListView()
    private var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = userListView
        setDelegate()
        setAction()
        setNavigationTitle(text: "Team Card", font: .systemFont(ofSize: 18, weight: .medium), alignment: .left)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUsers() // 유저 리스트 정보 가져오기
        
        // 숨긴 탭바 띄우기
        if let mainVC = self.navigationController?.parent as? MainViewController {
            mainVC.setTabBar(isHidden: false)
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 탭바 숨기기
        if let mainVC = self.navigationController?.parent as? MainViewController {
            mainVC.setTabBar(isHidden: true)
        }
    }
    
    // 딜리게이트 설정
    private func setDelegate() {
        userListView.collectionView.dataSource = self
        userListView.collectionView.delegate = self
    }
    
    // 액션 설정
    private func setAction() {
        // Add User 버튼 액션
        userListView.addUserButton.addTarget(self, action: #selector(touchUpInsideAddUserButton), for: .touchUpInside)
    }
    
    // Add User 버튼 액션
    @objc private func touchUpInsideAddUserButton() {
        let nextVC = CreateUserCardViewController(type: .create)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // 유저 배열 가져오기
    private func fetchUsers() {
        Task {
            do {
                let users = try await UserAPIService.fetchUsers()
                self.users = users

                DispatchQueue.main.async { [weak self] in
                    self?.userListView.collectionView.reloadData()
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
}

// UICollectionViewDataSource
extension UserListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCell.id, for: indexPath) as? UserCell else { return UICollectionViewCell() }
        
        cell.config(user: users[indexPath.row])
        return cell
    }
}

// UICollectionViewDelegate
extension UserListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let userId = users[indexPath.row].userID else { return }
        let nextVC = TemplateHeaderViewController(userId: userId)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
