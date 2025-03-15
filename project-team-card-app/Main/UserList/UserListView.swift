//
//  UserListView.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/6/25.
//

import UIKit
import SnapKit


// MARK: - UserListView
class UserListView: UIView, UICollectionViewDelegateFlowLayout {
    
    var users: [User] = []
    weak var delegate: UserListViewDelegate?
    
    // Add User Button
    public lazy var addUserButton = AddButton(type: .user)
    
    private let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 103)
        return layout
    }()
    public lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(UserCell.self, forCellWithReuseIdentifier: UserCell.identifier)
        view.register(UserListHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: UserListHeaderView.identifier)
        view.backgroundColor = .clear
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private func configureUI() {
        backgroundColor = .white
        
        [collectionView, addUserButton].forEach { addSubview($0) }
        
        collectionView.contentInsetAdjustmentBehavior = .never
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-150)
        }
        addUserButton.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UserListView: UICollectionViewDelegate, UICollectionViewDataSource{
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCell.identifier, for: indexPath) as? UserCell else {
            return UICollectionViewCell()
        }
        let user = users[indexPath.row]
        cell.configure(user: user)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: UserListHeaderView.identifier, for: indexPath) as? UserListHeaderView else {
            return UICollectionReusableView()
        }
        return header
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout (Grid 설정)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = collectionView.frame.width
        let cellWidth = (totalWidth - 10) / 2
        let cellHeight: CGFloat = 300
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let userId = users[indexPath.row].userID else {return}
        delegate?.didSelectUser(userId: userId)
    }
}
#Preview {
    UserListViewController()
}
