//
//  Untitled.swift
//  project-team-card-app
//
//  Created by 양원식 on 3/6/25.
//

import UIKit
import SnapKit

// MARK: - 커스텀 팀 룰 리스트 셀
class CustomTeamRulesListCell: UITableViewCell {
    
    // MARK: - 식별자 (셀 재사용을 위한 Identifier)
    static let identifier = "CustomTeamRulesListCell"

    // MARK: - UI 요소 정의

    // 아이콘 이미지 뷰
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit // 이미지 비율 유지
        imageView.clipsToBounds = true // 이미지가 뷰 영역을 넘지 않도록 설정
        imageView.layer.cornerRadius = 20 // 둥근 모서리 적용
        return imageView
    }()

    // 타이틀 라벨
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16) // 볼드체 적용
        label.textColor = .black // 기본 텍스트 색상
        return label
    }()

    // 설명 라벨
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14) // 일반 폰트
        label.textColor = .gray // 서브 텍스트 색상
        return label
    }()

    // 구분선 뷰
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray // 연한 회색 구분선
        return view
    }()

    // MARK: - 초기화 메서드
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI 구성 메서드

    private func setupUI() {
        // 셀 내부에 UI 요소 추가
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(separatorView)

        setupConstraints()
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
        descriptionLabel.snp.makeConstraints { make in
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

    // MARK: - 셀 데이터 설정 메서드

    /// 셀에 표시할 데이터를 설정하는 메서드
    /// - Parameters:
    ///   - image: 아이콘 이미지 (UIImage)
    ///   - title: 타이틀 텍스트 (String)
    ///   - description: 설명 텍스트 (String)
    func configure(with image: UIImage?, title: String, description: String) {
        iconImageView.image = image // 아이콘 설정
        titleLabel.text = title // 타이틀 설정
        descriptionLabel.text = description // 설명 설정
    }
}
