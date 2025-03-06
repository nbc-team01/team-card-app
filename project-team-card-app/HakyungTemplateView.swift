//
//  HakyungTemplateView.swift
//  project-team-card-app
//
//  Created by kingj on 3/6/25.
//

import UIKit
import SnapKit

class HakyungTemplateView: UIView {
    
    struct Constants {
        static let spacing20: CGFloat = 20
        static let spacing8: CGFloat = 8
        static let lableColor: UIColor = .label
        static let stackHeight: CGFloat = 50
    }
    
    // 수정 / 삭제는, navigation controller 사용

    private let scrollView: UIScrollView = {
        var view = UIScrollView()
        view.isScrollEnabled = true
        return view
    }()
    
    private let vStack: UIStackView = {
        var vstack = UIStackView()
        vstack.axis = .vertical
//        vstack.spacing = Constants.spacing20
        return vstack
    }()
    
    private let contentView: UIView = {
        var view = UIView()
        view.backgroundColor = .red
        
        return view
    }()
    
    private let profileView: UIImageView = {
        var imageView = UIImageView()
        imageView.backgroundColor = .brown
        return imageView
    }()
    
    private let hStack: UIStackView = {
        var hstack = UIStackView()
        hstack.axis = .horizontal
        hstack.distribution = .equalCentering
        hstack.spacing = Constants.spacing8
        return hstack
    }()
    
    private let nameLabel: UILabel = {
        var label = UILabel()
        label.text = "손하경"
        label.font = .systemFont(ofSize: 43, weight: .bold)
        label.textColor = Constants.lableColor
        return label
    }()
    
    private let vStackForLabel: UIStackView = {
        var vstack = UIStackView()
        vstack.axis = .vertical
        vstack.alignment = .leading
        vstack.distribution = .fillEqually
        return vstack
    }()
    
    private let nicknameLable: UILabel = {
        var label = UILabel()
        label.text = "a.k.a 비둘기 🐦"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = Constants.lableColor
        return label
    }()
    
    private let ageLable: UILabel = {
        var label = UILabel()
        label.text = "만 2x세"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = Constants.lableColor
        return label
    }()
    
    private let githubButton: UIButton = {
        var button = UIButton()
        button.tintColor = Constants.lableColor
        button.setImage(UIImage(named: "githubIcon"), for: .normal)
        return button
    }()
    
    private let blogButton: UIButton = {
        var button = UIButton()
        button.tintColor = Constants.lableColor
        button.setImage(UIImage(named: "blogIcon-Tistory"), for: .normal)
        return button
    }()
    
    private let mbtiLable: UILabel = {
        var label = UILabel()
        label.text = "ISFP"
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textColor = Constants.lableColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
        configureAutoLayout()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension HakyungTemplateView {
    
    func configureUI() {
        backgroundColor = .label
        
        addSubview(scrollView)
        scrollView.addSubview(vStack)
        
        vStack.addSubview(contentView)
        contentView.addSubview(profileView)
        contentView.addSubview(hStack)
        
        [nicknameLable, ageLable].forEach {
            vStackForLabel.addArrangedSubview($0)
        }
        
        [nameLabel, vStackForLabel, githubButton, blogButton].forEach {
            hStack.addArrangedSubview($0)
        }
        
    }
    
    func configureAutoLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
            make.height.equalTo(scrollView.snp.height)
        }
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(vStack)
            make.width.equalTo(vStack.snp.width)
            make.height.equalTo(UIScreen.main.bounds.size.height * 0.44)
        }
        
        profileView.translatesAutoresizingMaskIntoConstraints = false
        profileView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(contentView)
            make.width.equalTo(contentView.snp.width)
        }
        
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.snp.makeConstraints { make in
            make.width.equalTo(profileView.snp.width)
            make.height.equalTo(Constants.stackHeight)
            make.centerX.equalTo(contentView.snp.centerX)
            make.bottom.equalTo(contentView.snp.bottom).offset(-15)
        }
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(hStack.snp.leading).offset(14)
        }
        
        vStackForLabel.translatesAutoresizingMaskIntoConstraints = false
        vStackForLabel.snp.makeConstraints { make in
            make.height.equalTo(Constants.stackHeight)
            make.top.equalTo(hStack.snp.top)
            make.leading.equalTo(nameLabel.snp.trailing).offset(10)
        }
        
        nicknameLable.translatesAutoresizingMaskIntoConstraints = false
        nicknameLable.snp.makeConstraints { make in
            make.top.equalTo(vStackForLabel.snp.top).offset(2)
        }
        
        ageLable.translatesAutoresizingMaskIntoConstraints = false
        ageLable.snp.makeConstraints { make in
            make.top.equalTo(nicknameLable.snp.bottom).offset(-3)
        }
        
        githubButton.translatesAutoresizingMaskIntoConstraints = false
        githubButton.snp.makeConstraints { make in
            make.trailing.equalTo(blogButton.snp.leading).offset(-25)
        }
        
        blogButton.translatesAutoresizingMaskIntoConstraints = false
        blogButton.snp.makeConstraints { make in
            make.trailing.equalTo(profileView.snp.trailing).offset(-20)
        }
        
    }
}
