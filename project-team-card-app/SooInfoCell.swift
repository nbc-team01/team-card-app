//
//  SooInfoCell.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/3/25.
//

import UIKit

// 정보를 담을 공통 컴포넌트
class SooInfoCell: UITableViewCell {
    static let id = "SooInfoCell"
    private let title: String
    
    // 타이틀 라벨
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = title
        lbl.font = .systemFont(ofSize: 14, weight: .bold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    // description 라벨
    private let descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "임시"
        lbl.font = . systemFont(ofSize: 12)
        lbl.numberOfLines = 0
        lbl.backgroundColor = .systemPink
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    init(title: String) {
        self.title = title
        
        super.init(frame: .zero)
        setSubView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView() {
        [
            titleLabel,
            descriptionLabel
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI() {

        NSLayoutConstraint.activate([
            // 타이틀 라벨
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            // 설명 라벨
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
}
