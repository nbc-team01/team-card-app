//
//  Template_Quarang_HeaderView.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/6/25.
//

import UIKit
import SnapKit

class TemplateHeaderView: UIView {
    
    private let headerSafe:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "메인화면"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    private let spacerView: UIView = {
        let view = UIView()
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return view
    }()
    
    var changeTemplateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "dice"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    var menuButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private lazy var hstackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [dismissButton, mainLabel, spacerView, changeTemplateButton, menuButton])
        view.axis = .horizontal
        view.spacing = 10
        view.backgroundColor = .white
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = .init(top: 0, left: 10, bottom: 0, right: 10)
        return view
    }()
    
    let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray  // 구분선 색상
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubview(headerSafe)
        addSubview(hstackView)
        addSubview(divider)
        headerSafe.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.top).offset(15)
        }
        
        hstackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        divider.snp.makeConstraints {
            $0.top.equalTo(hstackView.snp.bottom).inset(-10)
            $0.height.equalTo(0.7)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
