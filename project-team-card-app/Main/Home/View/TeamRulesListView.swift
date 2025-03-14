//
//  CustomTeamRulesListView.swift
//  project-team-card-app
//
//  Created by 양원식 on 3/6/25.
//

import UIKit
import SnapKit

class TeamRulesListView: UIView{
    
    
    private let rules:[Team] = [
        Team(image: "rocket", title: "코드 리뷰는 필참!", content: "• 다같이 학습해요"),
        Team(image: "talk", title: "소통 예쁘게 하기!", content: "• 가는말이 고와야 오는말이 곱다."),
    ]
    private lazy var stackView:UIStackView = {
        let view = UIStackView(arrangedSubviews: rules.map{TeamRulesListCell(rule: $0)})
        view.axis = .vertical
        return view
    }()
    //MARK: - 초기화 메서드
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI 구성 메서드
    private func setupUI() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
