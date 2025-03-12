//
//  UITabbar+extension.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/12/25.
//

import Foundation
import UIKit

class CustomTabBar : UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 100
        return sizeThatFits
    }
}
