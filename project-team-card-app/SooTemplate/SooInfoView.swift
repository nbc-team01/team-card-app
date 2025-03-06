//
//  SooInfoView.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/4/25.
//

import UIKit

class CustomLabel: UILabel {
    private var padding = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)

    // UILabel에 패딩 추가
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    // intrinsicContentSize를 직접 조정하여 최소 높이를 보장하면
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        let minHeight = padding.top + padding.bottom + size.height // 최소 높이 보장
        return CGSize(width: size.width + padding.left + padding.right,
                      height: max(size.height + padding.top + padding.bottom, minHeight))
    }
}

// 정보를 담을 공통 컴포넌트
class SooInfoView: UIView {
    private let title: String
    private let content: String
    
    // 타이틀 라벨
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = title
        lbl.font = .systemFont(ofSize: 24, weight: .bold)
        lbl.numberOfLines = 1
        lbl.setContentCompressionResistancePriority(.required, for: .vertical)

        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }()
    
    // content 라벨
    private lazy var contentLabel: CustomLabel = {
        let lbl = CustomLabel()
        lbl.text = content
        lbl.font = . systemFont(ofSize: 20)
        lbl.numberOfLines = 0
        lbl.backgroundColor = .systemGray5
        lbl.layer.cornerRadius = 8
        lbl.clipsToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }()
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
        
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
            contentLabel
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
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            contentLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            contentLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    public func config(title: String, content: String){
        titleLabel.text = title
        contentLabel.text = content
    }
}
