//
//  UserListHeaderView.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/15/25.
//

import UIKit
import SnapKit

// MARK: - UserListHeaderView
class UserListHeaderView: UICollectionReusableView {
    static let identifier = "UserListHeaderView"
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Team Card"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
        addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }
    }
}
