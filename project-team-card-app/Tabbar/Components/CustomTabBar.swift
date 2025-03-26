//
//  UITabbar+extension.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/12/25.
//

import Foundation
import UIKit

//MARK: 탭바 높이 설정
//iOS 13.4부터 이유없이 UITabBar에서 탭바 높이 설정이 안된다고 해서 해당 방식 선택
class CustomTabBar : UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 100
        return sizeThatFits
    }
}
