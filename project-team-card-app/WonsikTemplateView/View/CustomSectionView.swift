//
//  CustomSectionView.swift
//  project-team-card-app
//
//  Created by 양원식 on 3/5/25.
//

import UIKit
import SnapKit

class CustomSectionView: UIView {
    
    //MARK: - UI 요소 정의
    
    // Section 제목
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 16, weight: .bold)
        return title
    }()
    
    // Section 내용
    private let contentLabel: UILabel = {
        let content = UILabel()
        content.font = .systemFont(ofSize: 14, weight: .regular)
        content.numberOfLines = 0 // 여러 줄 허용
        return content
    }()
    
    
    //MARK: - 초기화 메서드
    init(title: String, content: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        contentLabel.text = content
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI 구성 메서드
    private func setupUI() {
        backgroundColor = UIColor.systemGray6
        layer.cornerRadius = 10
        
        addSubview(titleLabel)
        addSubview(contentLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(10)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    //MARK: - UI 업데이트 메서드
    /// 제목과 내용을 업데이트하는 메서드
    func updateSection(title: String, content: String) {
        titleLabel.text = title
        contentLabel.text = content
    }
}
