//
//  HakyungCell.swift
//  project-team-card-app
//
//  Created by kingj on 3/6/25.
//

import UIKit
import SnapKit

// Cell For [Content]
class HakyungCell: UITableViewCell {
    
    static let identifier = "HakyungCell"
    
    private let titleLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = Constants.lableColor
        return label
    }()
    
    private let contentLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = Constants.lableColor
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        configureAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HakyungCell {
    private func configureUI() {
        contentView.backgroundColor = .clear
        [titleLabel, contentLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func configureAutoLayout() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(18)
            make.top.equalTo(contentView.snp.top).offset(18)
        }
        
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(18)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing).offset(26)
            make.bottom.equalTo(contentView.snp.bottom).offset(18)
        }
    }
    
    func setContentsData(contents: Content) {
        self.titleLabel.text = contents.title ?? ""
        self.contentLabel.text = contents.content ?? ""
    }
}
