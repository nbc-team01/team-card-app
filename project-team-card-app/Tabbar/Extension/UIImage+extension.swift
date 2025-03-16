//
//  UIImage+extension.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/12/25.
//

import Foundation
import UIKit

extension UIImage{
    func imageWithAlphaColor(alpha: CGFloat) -> UIImage? {
        return UIGraphicsImageRenderer(size: self.size).image { _ in
            self.draw(at: .zero, blendMode: .normal, alpha: alpha)
        }
    }
}
