//
//  TeamGoalsContainorView.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/13/25.
//

import Foundation
import UIKit
import SnapKit

//MARK: 팀 목표 뷰
class TeamGoalsView:UIView{
    let teamGoalsCard = [
        TeamGoalsCell(team: Team(image: "trophy", title: "목표", content: "iOS 마스터가 되기 위해!")),
        TeamGoalsCell(team: Team(image: "party", title: "다짐", content: "정상에서 봅시다!"))
    ]
    //MARK: 카드를 담을 컨테이너
    private lazy var goalCommitContainerView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: teamGoalsCard)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(goalCommitContainerView)
        goalCommitContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
