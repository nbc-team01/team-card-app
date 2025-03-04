//
//  CreateMemberInfoView.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/4/25.
//

import UIKit

// 텍스트 필드 그룹
class CreateMemberInfoView: UIView {
    // 타이틀
    private let title: String
    
    // 비밀번호 필드 보안
    private let isSecurity: Bool
    
    // 타이틀 라벨
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = title
        lbl.font = .systemFont(ofSize: 22)
        lbl.numberOfLines = 1
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    // 텍스트 필드
    private lazy var textField: UITextField = {
        let field = UITextField()
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        field.leftView = leftView
        field.leftViewMode = .always
        field.placeholder = "\(title)을(를) 입력해주세요."
        field.layer.cornerRadius = 8
        field.layer.borderWidth = 0.8
        field.layer.borderColor = UIColor.systemGray5.cgColor
        field.backgroundColor = .systemGray5
        field.clearButtonMode = .always
        field.isSecureTextEntry = self.isSecurity
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    init(title: String, isSecurity: Bool = false) {
        self.title = title
        self.isSecurity = isSecurity
        super.init(frame: .zero)
        
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        
//        self.setContentHuggingPriority(.required, for: .vertical)
//        self.setContentCompressionResistancePriority(.required, for: .vertical)
        
        setSubView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView(){
        [
            titleLabel,
            textField
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI() {
        NSLayoutConstraint.activate([
            // 타이틀 라벨
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            // 텍스트 필드
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
