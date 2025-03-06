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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchUsers()
    }
    
    // 딜리게이트 설정
    private func setDelegate() {
        userListView.collectionView.dataSource = self
        userListView.collectionView.delegate = self
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
        let user = users[indexPath.row]
        let nextVC = SooTemplateViewController(user: user)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
