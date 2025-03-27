//
//  PaddingLabel.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/6/25.
//

import UIKit

//MARK: 마진을 설정할 수 있는 라벨
class PaddingLabel: UILabel {
    private let padding: UIEdgeInsets
    
    init(topPadding: CGFloat, leftPadding: CGFloat, bottomPadding: CGFloat, rightPadding: CGFloat) {
        self.padding = UIEdgeInsets(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding)
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: UILabel에 패딩 추가
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    //MARK: intrinsicContentSize를 직접 조정하여 최소 높이를 보장하면
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        let height = padding.top + padding.bottom + size.height
        let width = padding.left + padding.right + size.width
        return CGSize(width: width, height: height)
    }
}
