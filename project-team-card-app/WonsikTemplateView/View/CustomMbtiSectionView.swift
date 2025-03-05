//
//  CustomMbtiSectionView.swift
//  project-team-card-app
//
//  Created by 양원식 on 3/5/25.
//

import UIKit
import SnapKit


class CustomMbtiView: UIView {
    
    //MARK: - UI 요소 정의
    
    private let mbtiLabel: UILabel = {
        let mbti = UILabel()
        mbti.text = "MBTI"
        mbti.font = .systemFont(ofSize: 16, weight: .bold)
        return mbti
    }()
    
    private let mbtiImage: UIImageView = {
        let mbtiImage = UIImageView()
        mbtiImage.image = UIImage(named: "ESFP") // 기본 이미지
        return mbtiImage
    }()
    
    //MARK: - 초기화 메서드
    init(mbti: String) {
        super.init(frame: .zero)
        mbtiImage.image = UIImage(named: mbti)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI 구성 메서드
    private func setupUI() {
        backgroundColor = UIColor.systemGray6
        layer.cornerRadius = 10
        
        addSubview(mbtiLabel)
        addSubview(mbtiImage)
        
        mbtiLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(10)
        }
        
        mbtiImage.snp.makeConstraints { make in
            make.top.equalTo(mbtiLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(400)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    //MARK: - MBTI 업데이트 메서드
    func updateSection(mbti: String) {
        mbtiImage.image = UIImage(named: mbti)
    }
}
