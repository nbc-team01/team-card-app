//
//  StyledPaddingLabel.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/15/25.
//

import Foundation
import UIKit

//MARK: paading 라벨 + 커스텀 속성 적용
class StyledPaddingLabel: PaddingLabel {
    
    // 커스텀 초기화 메서드
    init(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        super.init(topPadding: top, leftPadding: left, bottomPadding: bottom, rightPadding: right)
        configureLabelStyle()  // 스타일링 설정
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // 스타일을 적용하는 메서드
    private func configureLabelStyle() {
        self.font = .systemFont(ofSize: 12, weight: .regular)
        self.layer.cornerRadius = 2
        self.clipsToBounds = true
        self.backgroundColor = .black.withAlphaComponent(0.05)
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        self.layer.borderWidth = 0.5
        self.textAlignment = .center
    }
}
