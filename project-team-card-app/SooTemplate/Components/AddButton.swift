//
//  AddButton.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/6/25.
//

import UIKit

enum AddButtonType: String {
    case member = "Member" // 멤버 추가 버튼
    case content = "Content" // 컨텐츠 추가 버튼
}

class AddButton: UIButton {
    private let type: AddButtonType
    
    init(type: AddButtonType) {
        self.type = type
        super.init(frame: .zero)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.setTitle("Add \(type.rawValue)", for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
        self.layer.cornerRadius = 8
        self.backgroundColor = .black
        self.isUserInteractionEnabled = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
