//
//  TeamGoalsCell.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/13/25.
//

import Foundation
import UIKit
import SnapKit

//MARK: 커스텀 팀 목표 셀
class TeamGoalsCell:UIView{
    var team:Team
    //MARK:  개별 카드
    private lazy var cardView:UIStackView = {
        let view = UIStackView(arrangedSubviews: [imageView,titleLabel,contentLabel])
        view.axis = .vertical
        view.spacing = 10
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        view.clipsToBounds = true
        return view
    }()
    //MARK: 이미지
    private let imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .yellow
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    //MARK: 타이틀
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    //MARK: 내용
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    private func configure(){
        imageView.image = team.image
        titleLabel.text = team.title
        contentLabel.text = team.content
    }
    
    init(team:Team){
        self.team = team
        super.init(frame:.zero)
        addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
        }
    
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
