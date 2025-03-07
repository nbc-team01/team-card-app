//
//  HakyungTemplateView.swift
//  project-team-card-app
//
//  Created by kingj on 3/6/25.
//

import UIKit
import SnapKit
import Kingfisher

class HakyungTemplateView: UIView {
    
    let tableView = UITableView()
    
    private let scrollView: UIScrollView = {
        var view = UIScrollView()
        view.isScrollEnabled = true
        return view
    }()
    
    private let vstack: UIStackView = {
        var view = UIStackView()
        view.axis = .vertical
        return view
    }()
    
    /// 상단 뷰
    private let contentView: UIView = {
        var view = UIView()
        
        return view
    }()
    
    private let profileView: UIImageView = {
        var imageView = UIImageView()
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
        label.font = .systemFont(ofSize: 43, weight: .bold)
        label.textColor = Constants.lableColor
        return label
    }()
    
    private let vStackForLabel: UIStackView = {
        var vstack = UIStackView()
        vstack.axis = .vertical
        vstack.alignment = .leading
        vstack.spacing = 1
        vstack.distribution = .fillEqually
        return vstack
    }()
    
    private let nicknameLable: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = Constants.lableColor
        return label
    }()
    
    private let ageLable: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = Constants.lableColor
        return label
    }()
    
    private var githubUrl: String?
    private let githubButton: UIButton = {
        var button = UIButton()
        button.tintColor = Constants.lableColor
        button.setImage(UIImage(named: "githubIcon"), for: .normal)
        return button
    }()
    
    private var blogUrl: String?
    private let blogButton: UIButton = {
        var button = UIButton()
        button.tintColor = Constants.lableColor
        button.setImage(UIImage(named: "blogIcon-Tistory"), for: .normal)
        return button
    }()
    
    private let mbtiLable: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textColor = Constants.lableColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureAction()
        configureUI()
        configureAutoLayout()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HakyungTemplateView {
    
    func setUserInfo(user: User) {
        self.profileView.kf.setImage(with: URL(string: user.imagePathURL!))
        self.nameLabel.text = user.name
        self.nicknameLable.text = user.nickname
        self.ageLable.text = "\(user.age!)"
        self.mbtiLable.text = user.mbti
        self.githubUrl = user.gitHubPathURL!
        self.blogUrl = user.blogPathURL!
    }
    
    private func configureAction() {
        self.githubButton.addTarget(self, action: #selector(openSafariGithub), for: .touchUpInside)
        self.blogButton.addTarget(self, action: #selector(openSafariBlog), for: .touchUpInside)
    }
    
    @objc func openSafariGithub() {
        if let urlString = githubUrl, let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                print("Cant Open Safari")
            }
        }
    }
    
    @objc func openSafariBlog() {
        if let urlString = blogUrl, let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                print("Cant Open Safari")
            }
        }
    }
    
    private func configureUI() {
        backgroundColor = .label
        
        addSubview(scrollView)
        
        scrollView.addSubview(vstack)
        
        vstack.addArrangedSubview(contentView)
        vstack.addArrangedSubview(tableView)
        
        contentView.addSubview(profileView)
        contentView.addSubview(hStack)
        
        [nicknameLable, ageLable].forEach {
            vStackForLabel.addArrangedSubview($0)
        }
        
        [nameLabel, vStackForLabel, githubButton, blogButton].forEach {
            hStack.addArrangedSubview($0)
        }
        
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func configureAutoLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        vstack.translatesAutoresizingMaskIntoConstraints = false
        vstack.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
//            make.height.equalTo(scrollView.snp.height)
        }
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(vstack)
            make.width.equalTo(scrollView.snp.width)
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
            make.leading.equalTo(nameLabel.snp.trailing).offset(14)
        }
        
        nicknameLable.translatesAutoresizingMaskIntoConstraints = false
        nicknameLable.snp.makeConstraints { make in
//            make.top.equalTo(vStackForLabel.snp.top).offset(2)
        }
        
        ageLable.translatesAutoresizingMaskIntoConstraints = false
        ageLable.snp.makeConstraints { make in
//            make.top.equalTo(nicknameLable.snp.bottom).offset(-3)
        }
        
        githubButton.translatesAutoresizingMaskIntoConstraints = false
        githubButton.snp.makeConstraints { make in
            make.trailing.equalTo(blogButton.snp.leading).offset(-23)
        }
        
        blogButton.translatesAutoresizingMaskIntoConstraints = false
        blogButton.snp.makeConstraints { make in
            make.trailing.equalTo(profileView.snp.trailing).offset(-20)
        }
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.snp.makeConstraints { make in
            make.width.equalTo(contentView.snp.width)
            make.height.equalTo(600)
            make.top.equalTo(contentView.snp.bottom)
            make.bottom.leading.trailing.equalTo(scrollView)
        }
    }
    
}

struct Constants {
    static let spacing20: CGFloat = 20
    static let spacing8: CGFloat = 8
    static let lableColor: UIColor = .black
    static let stackHeight: CGFloat = 50
}
