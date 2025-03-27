//
//  AddButton.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/6/25.
//

import UIKit

//MARK: 버튼 속성(normal -> 가득채워진 버튼, border -> 테두리가 있는 버튼)
enum ButtonThemeType{
    case normal
    case border
}
//MARK: 앱 프로젝트에서 전역에서 사용되는 커스텀 버튼
class AddButton: UIButton {
    private let type:ButtonThemeType
    private let text: String
    private let buttonColor: UIColor
    private let themeColor: UIColor
    
    init(type:ButtonThemeType,text:String,buttonColor:UIColor,themeColor:UIColor) {
        self.type = type
        self.text = text
        self.buttonColor = buttonColor
        self.themeColor = themeColor
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.setTitle(text, for: .normal)
        self.setTitleColor(themeColor, for: .normal)
        self.backgroundColor = buttonColor
        self.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
        self.layer.cornerRadius = 8
        switch self.type{
        case .normal: return
        case .border:
            self.layer.borderColor = themeColor.cgColor
            self.layer.borderWidth = 1
            self.clipsToBounds = true
        }
    }
}
