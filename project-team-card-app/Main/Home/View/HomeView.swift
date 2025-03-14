//
//  HomeView.swift
//  project-team-card-app
//
//  Created by 양원식 on 3/6/25.
//

import UIKit
import SnapKit

class HomeView: UIView {
    
    //MARK: - UI 요소 정의
    
    // 실제 UI를 담을 뷰
    private let contentView = UIView()
    // 팀 이미지
    private let teamImage = UIImageView(image: UIImage(named: "sampleTeamImage"))
    // 팀 룰 리스트
    private let teamRulesListView = TeamRulesListView()
    // 팀 목표 카드
    private let teamGoalsView = TeamGoalsView()
    // 스크롤 뷰 생성
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false // 세로 스크롤바 숨김
        return scrollView
    }()
    // 타이틀
    private let teamTitleLabal: UILabel = {
        let teamTitle = UILabel()
        teamTitle.text = "Team 1"
        teamTitle.font = .systemFont(ofSize: 25, weight: .bold)
        return teamTitle
    }()
    // 서브 타이틀
    private let subTitleLabal: UILabel = {
        let subTitle = UILabel()
        subTitle.text = "내배캠 iOS 마스터 6기"
        subTitle.font = .systemFont(ofSize: 14, weight: .bold)
        subTitle.textColor = .systemGray
        return subTitle
    }()
    // 팀 룰
    private let teamRulesTitleLabal: UILabel = {
        let teamRulesTitle = UILabel()
        teamRulesTitle.text = "Team Rules"
        teamRulesTitle.font = .systemFont(ofSize: 20, weight: .bold)
        return teamRulesTitle
    }()
    private let teamGoalsTitleLabal: UILabel = {
        let teamRulesTitle = UILabel()
        teamRulesTitle.text = "Team Goals"
        teamRulesTitle.font = .systemFont(ofSize: 20, weight: .bold)
        return teamRulesTitle
    }()
    
    //MARK: - 초가화 메서드
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
//        configureRules()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI 구성 메서드
    private func setupUI() {
        backgroundColor = .white
        addSubview(scrollView)
        //각 요소 추가
        scrollView.addSubview(contentView)
        contentView.addSubview(teamTitleLabal)
        contentView.addSubview(subTitleLabal)
        contentView.addSubview(teamImage)
        // 팀 룰 추가
        contentView.addSubview(teamRulesTitleLabal)
        contentView.addSubview(teamRulesListView)
        
        // 팀 목표카드 추가
        contentView.addSubview(teamGoalsTitleLabal)
        contentView.addSubview(teamGoalsView)

        // 스크롤 뷰 설정
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // contentView 설정
        contentView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.width.equalToSuperview()
        }
        // 타이틀
        teamTitleLabal.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
        }
        // 서브 타이틀
        subTitleLabal.snp.makeConstraints { make in
            make.top.equalTo(teamTitleLabal.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
        }
        // 팀 이미지
        teamImage.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabal.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(400)
        }
        // 팀 룰 타이틀
        teamRulesTitleLabal.snp.makeConstraints { make in
            make.top.equalTo(teamImage.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
        }
        // 팀 룰 리스트
        teamRulesListView.snp.makeConstraints { make in
            make.top.equalTo(teamRulesTitleLabal.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(16)
        }
        //팀 카드 타이틀
        teamGoalsTitleLabal.snp.makeConstraints { make in
            make.top.equalTo(teamRulesListView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(10)
        }
        //팀 카드
        teamGoalsView.snp.makeConstraints { make in
            make.top.equalTo(teamGoalsTitleLabal.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
