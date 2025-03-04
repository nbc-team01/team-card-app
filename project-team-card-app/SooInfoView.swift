//
//  SooInfoView.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/4/25.
//

import UIKit

// 정보를 담을 공통 컴포넌트
class SooInfoView: UIView {
    private let title: String
    
    // 타이틀 라벨
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = title
        lbl.font = .systemFont(ofSize: 28, weight: .bold)
        lbl.numberOfLines = 1
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    // description 라벨
    private let descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시임시"
        lbl.font = . systemFont(ofSize: 24)
        lbl.numberOfLines = 0
        lbl.backgroundColor = .systemPink
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    init(title: String) {
        self.title = title
        
        super.init(frame: .zero)
        self.backgroundColor = .clear
        self.setContentHuggingPriority(.required, for: .vertical)
        self.setContentCompressionResistancePriority(.required, for: .vertical)
        self.translatesAutoresizingMaskIntoConstraints = false
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
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),

            // 설명 라벨
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
