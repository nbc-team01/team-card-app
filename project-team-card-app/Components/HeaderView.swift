//
//  UserListHeaderView.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/15/25.
//

import UIKit
import SnapKit

// MARK: - 커스텀 UserListHeaderView
class HeaderView: UICollectionReusableView {
    static let identifier = "HeaderView"
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    override init(frame:CGRect) {
        super.init(frame: .zero)
        configureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(title: String) {
        headerLabel.text = title
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
