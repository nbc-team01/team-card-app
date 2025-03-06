//
//  DetailsView.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/6/25.
//

import UIKit
import SnapKit

class Template_Quarang_DetailsView: UIView {
    
    private lazy var emojiView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.95, alpha: 1) // 아주 흰색에 가까운 회색
        view.layer.cornerRadius = 30 // 동그랗게 만들기
        view.layer.masksToBounds = true
        view.addSubview(emojiLabel)
        return view
    }()
    
    private let emojiLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .right
        return label
    }()
    private let linkLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .gray
        label.textAlignment = .right
        return label
    }()
    private let spacerView: UIView = {
        let view = UIView()
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return view
    }()
    private lazy var stackView:UIStackView = {
        let view = UIStackView(arrangedSubviews: [emojiView,vstackView,spacerView,valueLabel])
        view.axis = .horizontal
        view.spacing = 10
        return view
    }()
    private lazy var vstackView:UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel,linkLabel])
        view.alignment = .leading
        view.axis = .vertical
        view.spacing = 0
        return view
    }()
    private lazy var divider:UIView = {
       let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    init(emoji:String,title:String,value:String?,link:String?) {
        super.init(frame: .zero)
        configureView(emoji: emoji, title: title, value: value, link: link)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView(emoji:String,title:String,value:String?,link:String?) {
        addSubview(stackView)
        addSubview(divider)
        
        emojiLabel.text = emoji
        titleLabel.text = title
        valueLabel.text = value
        linkLabel.text = link
        
        emojiLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        emojiView.snp.makeConstraints{
            $0.width.height.equalTo(50)
        }
        stackView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        divider.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).inset(-10)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
}
