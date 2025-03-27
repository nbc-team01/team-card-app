//
//  Untitled.swift
//  project-team-card-app
//
//  Created by 양원식 on 3/6/25.
//

import UIKit
import SnapKit


// MARK: - 커스텀 팀 룰 리스트 셀
class TeamRulesListCell: UIView {
    
    // MARK: - 식별자 (셀 재사용을 위한 Identifier)
    var rule:Team
    
    //MARK:  아이콘 이미지 뷰
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView(image: rule.image)
        imageView.contentMode = .scaleAspectFit // 이미지 비율 유지
        imageView.clipsToBounds = true // 이미지가 뷰 영역을 넘지 않도록 설정
        imageView.layer.cornerRadius = 20 // 둥근 모서리 적용
        return imageView
    }()
    //MARK: 타이틀 라벨
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = rule.title
        label.font = UIFont.boldSystemFont(ofSize: 16) // 볼드체 적용
        label.textColor = .black // 기본 텍스트 색상
        return label
    }()
    //MARK:  설명 라벨
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = rule.content
        label.font = UIFont.systemFont(ofSize: 14) // 일반 폰트
        label.textColor = .gray // 서브 텍스트 색상
        return label
    }()
    //MARK:  구분선 뷰
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray // 연한 회색 구분선
        return view
    }()
    
    init(rule:Team) {
        self.rule = rule
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI 구성 메서드
    private func setupUI() {
        // 셀 내부에 UI 요소 추가
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(contentLabel)
        addSubview(separatorView)
    }

    // MARK: - 오토레이아웃 설정
    private func setupConstraints() {
        // 아이콘 이미지 뷰
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16) // 좌측 여백 16
            make.centerY.equalToSuperview() // 수직 중앙 정렬
            make.width.height.equalTo(40) // 정사각형 크기 40
        }

        // 타이틀 라벨
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10) // 상단 여백 10
            make.leading.equalTo(iconImageView.snp.trailing).offset(12) // 아이콘과 간격 12
            make.trailing.equalToSuperview().offset(-16) // 우측 여백 16
        }

        // 설명 라벨
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4) // 타이틀 아래 여백 4
            make.leading.equalTo(titleLabel) // 타이틀과 정렬
            make.trailing.equalToSuperview().offset(-16) // 우측 여백 16
            make.bottom.equalToSuperview().offset(-10) // 하단 여백 10
        }

        // 구분선 뷰
        separatorView.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel) // 타이틀과 정렬
            make.trailing.equalToSuperview() // 전체 너비
            make.bottom.equalToSuperview() // 하단에 위치
            make.height.equalTo(1) // 높이 1
        }
    }
}
