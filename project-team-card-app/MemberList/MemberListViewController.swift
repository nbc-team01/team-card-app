//
//  MemberListViewController.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/6/25.
//

import UIKit

class MemberListViewController: UIViewController {
    private let memberListView = MemberListView()
    private var members = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = memberListView
        setDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchUsers()
    }
    
    // 딜리게이트 설정
    private func setDelegate() {
        memberListView.collectionView.dataSource = self
    }
    
    // 유저 배열 가져오기
    private func fetchUsers() {
        Task {
            do {
                let users = try await UserAPIService.fetchUsers()
                self.members = users
                
                DispatchQueue.main.async { [weak self] in
                    self?.memberListView.collectionView.reloadData()
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension MemberListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return members.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemberCell.id, for: indexPath) as? MemberCell else { return UICollectionViewCell() }
        
        cell.config(user: members[indexPath.row])
        return cell
    }
}
