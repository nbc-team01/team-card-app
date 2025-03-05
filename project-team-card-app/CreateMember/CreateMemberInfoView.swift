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
    
    // placeholder
    private let placeholder: String
    
    // 텍스트 필드 높이 설정
    private let isLongText: Bool
    
    // 타이틀 라벨
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = title
        lbl.font = .systemFont(ofSize: 14, weight: .bold)
        lbl.numberOfLines = 1
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    // 텍스트 뷰
    public lazy var textView: UITextView = {
        let view = CustomTextView()
        view.text = placeholder
        view.placeHolderText = placeholder
        view.textColor = .placeholderText
        view.font = .systemFont(ofSize: 14, weight: .regular)
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        view.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//    // 텍스트 필드
    private lazy var textField: UITextField = {
        let field = UITextField()
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        field.leftView = leftView
        field.leftViewMode = .always
        field.placeholder = placeholder
        field.font = .systemFont(ofSize: 14, weight: .regular)
        field.layer.cornerRadius = 6
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        field.clearButtonMode = .always
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    init(title: String, placeholder: String, isLongText: Bool = false) {
        self.title = title
        self.placeholder = placeholder
        self.isLongText = isLongText
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
            isLongText ? textView : textField,
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI() {
        let textSpace = isLongText ? textView : textField
        
        NSLayoutConstraint.activate([
            // 타이틀 라벨
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            // 텍스트 필드
            textSpace.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            textSpace.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            textSpace.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            textSpace.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            textSpace.heightAnchor.constraint(equalToConstant: isLongText ? 111 : 36),
            
        ])
    }
}
