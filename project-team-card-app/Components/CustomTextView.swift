//
//  CustomTextView.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/5/25.
//

import UIKit
import SnapKit

class CustomTextView: UITextView, UITextViewDelegate {
    
    lazy var placeHolderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray.withAlphaComponent(0.75)
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(placeHolder: String) {
        placeHolderLabel.text = placeHolder
    }
    func textViewDidChange(_ textView: UITextView) {
        placeHolderLabel.isHidden = !textView.text.isEmpty
    }
    private func setup() {
        addSubview(placeHolderLabel)
        placeHolderLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        textColor = .black
        isScrollEnabled = true
        layer.borderColor = UIColor.gray.withAlphaComponent(0.15).cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
        
        delegate = self
    }
}

#Preview{
    CreateUserCardViewController(type: .modify(userId: "00978D33-1DD6-42F4-9C11-4B421A86AEF9"))
//    CreateUserCardViewController(type: .create)
}

