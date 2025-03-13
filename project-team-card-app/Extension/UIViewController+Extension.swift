//
//  UIViewController+Extension.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/13/25.
//

import UIKit

enum NavigationTitleAlignment {
    case left
    case right
    case center
}

extension UIViewController {
    func setNavigationTitle(text: String, font: UIFont, alignment: NavigationTitleAlignment, textColor: UIColor = .black){
        let titleLabel: UILabel = {
            let lbl = UILabel()
            lbl.text = text
            lbl.font = font
            lbl.textColor = textColor
            return lbl
        }()
        
        switch alignment {
        case .left:
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel) // leftBarButtonItem 설정
        case .right:
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: titleLabel) // rightBarButtonItem 설정
        case .center:
            self.navigationItem.titleView = titleLabel // 중앙 타이틀 뷰로 설정
        }
    }
}
