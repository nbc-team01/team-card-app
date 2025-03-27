//
//  UserSkeletonCell.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/21/25.
//

import UIKit
import SnapKit

//MARK: 유저 리스트 컬렉션 뷰 스켈레톤 셀
class UserSkeletonCell: UICollectionViewCell {
    static let identifier = "SkeletonCell"

    private let gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSkeletonView()
        setupGradientAnimation()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSkeletonView() {
        contentView.layer.addSublayer(gradientLayer)
        gradientLayer.colors = [
            UIColor.lightGray.withAlphaComponent(0.05).cgColor,
            UIColor.lightGray.withAlphaComponent(0.1).cgColor,
            UIColor.lightGray.withAlphaComponent(0.05).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = contentView.bounds
        gradientLayer.cornerRadius = 10
    }

    private func setupGradientAnimation() {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.5, 1.0]
        animation.toValue = [-1.0, 0.0, 1.0]
        animation.duration = 1.5
        animation.repeatCount = .infinity
        gradientLayer.add(animation, forKey: "skeletonAnimation")
    }
}
