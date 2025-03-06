//
//  TabbarView.swift
//  project-team-card-app
//
//  Created by 양원식 on 3/6/25.
//

import UIKit

class CustomTabBarView: UIView {
    
    // MARK: - Properties
    
    var onTabSelected: ((Int) -> Void)? // 탭 변경 이벤트를 전달하는 클로저
    
    // MARK: - UI 요소 정의
    
    // 홈 버튼
    private let homeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Home"), for: .normal)
        return button
    }()
    
    // 홈 라벨
    private let homeLabel: UILabel = {
        let label = UILabel()
        label.text = "홈"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    // 멤버카드 버튼
    private let cardButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Member"), for: .normal)
        button.alpha = 0.5 // 기본적으로 비활성화 상태
        return button
    }()
    
    // 멤버카드 라벨
    private let cardLabel: UILabel = {
        let label = UILabel()
        label.text = "멤버카드"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - 초기화 메서드
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI 구성 메서드
    
    private func setupUI() {
        backgroundColor = .white
        
        // 그림자 효과 추가
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: -2)
        layer.shadowRadius = 4
        
        // 홈 버튼과 라벨을 수직 스택으로 배치
        let homeStack = UIStackView(arrangedSubviews: [homeButton, homeLabel])
        homeStack.axis = .vertical
        homeStack.alignment = .center
        
        // 멤버카드 버튼과 라벨을 수직 스택으로 배치
        let cardStack = UIStackView(arrangedSubviews: [cardButton, cardLabel])
        cardStack.axis = .vertical
        cardStack.alignment = .center
        
        // 두 개의 스택을 가로 스택으로 배치하여 균등 분배
        let stackView = UIStackView(arrangedSubviews: [homeStack, cardStack])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        
        // 오토레이아웃 설정
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15) // 하단 여백 추가
        }
    }
    
    // MARK: - 버튼 액션 설정
    
    private func setupActions() {
        // 버튼 클릭 이벤트 연결
        homeButton.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
        cardButton.addTarget(self, action: #selector(cardButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - 버튼 클릭 이벤트 핸들러
    
    /// 홈 버튼 클릭 시 실행되는 함수
    @objc private func homeButtonTapped() {
        updateTabSelection(selectedIndex: 0)
        onTabSelected?(0)
    }
    
    /// 멤버카드 버튼 클릭 시 실행되는 함수
    @objc private func cardButtonTapped() {
        updateTabSelection(selectedIndex: 1)
        onTabSelected?(1)
    }
    
    // MARK: - UI 업데이트 메서드
    
    /// 버튼의 활성화/비활성화를 업데이트하는 함수
    private func updateTabSelection(selectedIndex: Int) {
        let isHomeSelected = selectedIndex == 0
        
        // 선택된 탭의 버튼과 라벨 스타일 변경
        homeButton.alpha = isHomeSelected ? 1.0 : 0.5
        cardButton.alpha = isHomeSelected ? 0.5 : 1.0
        homeLabel.textColor = isHomeSelected ? .black : .gray
        cardLabel.textColor = isHomeSelected ? .gray : .black
    }
}
