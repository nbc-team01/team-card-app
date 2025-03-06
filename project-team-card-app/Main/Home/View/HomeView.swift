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
    
    // 스크롤 뷰 생성
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true // 세로 스크롤바 숨김
        return scrollView
    }()
    
    // 실제 UI를 담을 뷰
    private let contentView: UIView = {
        let view = UIView()
        return view
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
    
    // 팀 이미지
    private let teamImage: UIImageView = {
        let teamImage = UIImageView()
        teamImage.image = UIImage(named: "sampleTeamImage")
        return teamImage
    }()
    
    // 팀 룰
    private let teamRulesTitleLabal: UILabel = {
        let teamRulesTitle = UILabel()
        teamRulesTitle.text = "Team Rules"
        teamRulesTitle.font = .systemFont(ofSize: 20, weight: .bold)
        return teamRulesTitle
    }()
    
    // 팀 룰 리스트
    private let teamRulesListView = CustomTeamRulesListView()
    
    // 팀 룰 데이터 설정
    private func configureRules() {
        // 형식 [ 이미지 , 타이틀 , 내용 ]
        // 현재 이미지는 임시 / SF Symbols에 있는 이미지 써도 될것같음.
        teamRulesListView.rules = [
            (UIImage(named: "rocket"), "코드 리뷰는 필참!", "• 다같이 학습해요"),
            (UIImage(named: "talk"), "소통 예쁘게 하기!", "• 가는말이 고와야 오는말이 곱다.")
        ]
    }
    
    // 목표 & 다짐을 담을 컨테이너 뷰
    private let goalCommitContainerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    // 개별 카드 UI (목표 카드)
    private let goalCardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.clipsToBounds = true
        return view
    }()

    private let goalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "trophy")
        imageView.tintColor = .yellow
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let goalTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "목표"
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()

    private let goalDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "iOS 마스터가 되기 위해!"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()

    // 개별 카드 UI (다짐 카드)
    private let commitCardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.clipsToBounds = true
        return view
    }()

    private let commitImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "party") // 파티 이미지 (SF Symbols 가능)
        imageView.tintColor = .systemPink
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let commitTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "다짐"
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()

    private let commitDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "정상에서 봅시다!"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    
    //MARK: - 초가화 메서드
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureRules()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI 구성 메서드
    private func setupUI() {
        backgroundColor = .white
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(teamTitleLabal)
        contentView.addSubview(subTitleLabal)
        contentView.addSubview(teamImage)
        contentView.addSubview(teamRulesTitleLabal)
        contentView.addSubview(teamRulesListView)
        
        // 목표 카드 추가
        contentView.addSubview(goalCardView)
        goalCardView.addSubview(goalImageView)
        goalCardView.addSubview(goalTitleLabel)
        goalCardView.addSubview(goalDescriptionLabel)

        // 다짐 카드 추가
        contentView.addSubview(commitCardView)
        commitCardView.addSubview(commitImageView)
        commitCardView.addSubview(commitTitleLabel)
        commitCardView.addSubview(commitDescriptionLabel)
        // 스크롤 뷰 설정
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // contentView 설정
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalTo(goalCardView.snp.bottom).offset(20)
        }
        
        // 타이틀
        teamTitleLabal.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(10)
        }
        
        // 서브 타이틀
        subTitleLabal.snp.makeConstraints { make in
            make.top.equalTo(teamTitleLabal.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
        }
        
        
        // 팀 이미지
        teamImage.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabal.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(400)
        }
        
        // 팀 룰 타이틀
        teamRulesTitleLabal.snp.makeConstraints { make in
            make.top.equalTo(teamImage.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(10)
        }
        
        
        // 팀 룰 리스트
        teamRulesListView.snp.makeConstraints { make in
            make.top.equalTo(teamRulesTitleLabal.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(130) // 리스트 높이 조절 가능
        }
        
        // 목표 카드 레이아웃
        goalCardView.snp.makeConstraints { make in
            make.top.equalTo(teamRulesListView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.width.equalToSuperview().multipliedBy(0.45) // 전체 화면의 45% 너비
            make.height.equalTo(150) // 카드 높이 조정 가능
        }

        goalImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(60)
        }

        goalTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(goalImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }

        goalDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(goalTitleLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }

        // 다짐 카드 레이아웃
        commitCardView.snp.makeConstraints { make in
            make.top.equalTo(goalCardView.snp.top)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalToSuperview().multipliedBy(0.45) // 전체 화면의 45% 너비
            make.height.equalTo(150) // 카드 높이 조정 가능
        }

        commitImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(60)
        }

        commitTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(commitImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }

        commitDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(commitTitleLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        
    }
    
}
