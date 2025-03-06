//
//  MemberListView.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/6/25.
//

import UIKit

class MemberListView: UIView {
    
    // 해더
    private let headerLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Team Card"
        lbl.font = .systemFont(ofSize: 18, weight: .medium)
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    // 컬렉션 뷰
    public let collectionView: UICollectionView = {
        // 레이아웃
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 12
        
        // (스크린의 너비 - 양쪽 패딩 - 셀 간격) / 2
        let cellWidth = (UIScreen.main.bounds.width - (12 * 2 + 8)) / 2
        let cellHeight = cellWidth * 1.7
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        // 컬렉션 뷰
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MemberCell.self, forCellWithReuseIdentifier: MemberCell.id)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // Add MemberButton
    public let addMemberButton = AddButton(type: .member)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        setSubView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView() {
        [
            headerLabel,
            collectionView,
            addMemberButton
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI() {
        NSLayoutConstraint.activate([
            
            // 헤더
            headerLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            headerLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            headerLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            headerLabel.heightAnchor.constraint(equalToConstant: 24),
            
            // 컬렉션 뷰
            collectionView.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            collectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            collectionView.bottomAnchor.constraint(equalTo: self.addMemberButton.topAnchor, constant: -8),
            
            // 버튼
            addMemberButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            addMemberButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            addMemberButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            addMemberButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
