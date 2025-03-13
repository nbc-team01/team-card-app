//
//  SooCustomInfoCell.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/13/25.
//

import UIKit

// 정보를 담을 공통 컴포넌트
class SooCustomInfoCell: UITableViewCell {
    static let id = "SooCustomInfoCell"
    
    // 타이틀 라벨
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 24, weight: .bold)
        lbl.numberOfLines = 1
        lbl.setContentCompressionResistancePriority(.required, for: .vertical)

        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }()
    
    // content 라벨
    private lazy var contentLabel: PaddingLabel = {
        let lbl = PaddingLabel(topPadding: 10, leftPadding: 10, bottomPadding: 10, rightPadding: 10)
        lbl.font = . systemFont(ofSize: 20)
        lbl.numberOfLines = 0
        lbl.backgroundColor = .systemGray5
        lbl.layer.cornerRadius = 8
        lbl.clipsToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.isUserInteractionEnabled = false
        self.backgroundColor = .clear
        
        setSubView()
        setUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func layoutSubviews() {
//      super.layoutSubviews()
//          // Cell 간격 조정
//      contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16))
//    }
//    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        contentLabel.text = nil
    }
    
    private func setSubView() {
        [
            titleLabel,
            contentLabel
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI() {

        NSLayoutConstraint.activate([
            // 타이틀 라벨
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),

            // 설명 라벨
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            contentLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            contentLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            contentLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
    
    public func config(title: String, content: String){
        titleLabel.text = title
        contentLabel.text = content
    }
}
