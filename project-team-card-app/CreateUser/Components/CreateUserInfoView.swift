//
//  CreateUserInfoView.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/4/25.
//

import UIKit
import SnapKit

// 텍스트 필드 그룹
class CreateUserInfoView: UIView {
    // 타이틀
    private let title: String
    // placeholder
    private let placeholder: String
    // 텍스트 필드 높이 설정
    public let isLongText: Bool
    // 삭제 가능 유무
    private let isContent: Bool
    // 텍스트 뷰
    lazy var textView = CustomTextView()
    // 타이틀 라벨
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    // 삭제 버튼
    public lazy var removeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "minus.circle.fill"), for: .normal)
        button.tintColor = .red
        button.isHidden = !isContent
        return button
    }()
    // 텍스트 필드
    public lazy var textField: UITextField = {
        let field = UITextField()
        field.placeholder = placeholder
        field.font = .systemFont(ofSize: 14, weight: .regular)
        field.borderStyle = .roundedRect
        field.clearButtonMode = .whileEditing
        return field
    }()
    // 에러 라벨
    public let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "필수로 입력해주세요"
        label.textColor = .red
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.isHidden = true
        return label
    }()
    init(title: String, placeholder: String, isLongText: Bool = false, isContent: Bool = false) {
        self.title = title
        self.placeholder = placeholder
        self.isLongText = isLongText
        self.isContent = isContent
        super.init(frame: .zero)
        self.isUserInteractionEnabled = true
        setSubView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView(){
        [titleLabel,removeButton,isLongText ? textView : textField,errorLabel]
            .forEach{ addSubview($0) }
    }
    
    private func setUI() {
        textView.configure(placeHolder: "Enter your Introduce")
        let textSpace = isLongText ? textView : textField
        
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        removeButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview()
        }
        textSpace.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview()
            guard isLongText else { return }
            make.height.equalTo(100)
        }
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(textSpace.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
}
#Preview{
//    CreateUserCardViewController(type: .modify(userId: "00978D33-1DD6-42F4-9C11-4B421A86AEF9"))
    CreateUserCardViewController(type: .create)
}
