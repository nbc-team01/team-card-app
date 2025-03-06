//
//  SooTemplateView.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/3/25.
//

import UIKit
import Kingfisher

class SooTemplateView: UIView {
    // 탑 버튼 크기 (편집, 삭제)
    private let topButtonWidthHeight: CGFloat = 30
    
    // 링크 버튼 크기 (깃, 블로그)
    private let linkButtonWidthHeight: CGFloat = 40

    // 스크롤뷰
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 컨텐트 뷰
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 프로필 이미지 뷰
    private let profileImageView: UIImageView = {
        let imgView = UIImageView()
//        imgView.image = .githubMark
        imgView.backgroundColor = .placeholderText
        imgView.contentMode = .scaleToFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    // 그라데이션 뷰
    private let gradientView: UIView = {
        let view = UIView()
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 150)
        layer.colors = [
//            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.8).cgColor,
            UIColor.black.withAlphaComponent(0.5).cgColor,
            UIColor.black.withAlphaComponent(0.3).cgColor,
            UIColor.black.withAlphaComponent(0.1).cgColor,
            UIColor.clear.cgColor
        ]
        view.layer.addSublayer(layer)
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 닉네임 / 이름 (나이) 라벨
    private let userInfoLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "닉네임 / 이름 (나이)"
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 26, weight: .semibold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

//    
    // MBTI
    private let mbtiLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "임시 MBTI"
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 24, weight: .semibold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    // 깃허브 버튼
    public lazy var gitButton: UIButton = {
        let btn = UIButton()
        btn.setImage(.githubMark, for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.backgroundColor = .white
        btn.layer.cornerRadius = linkButtonWidthHeight / 2
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    // 블로그 버튼
    public lazy var blogButton: UIButton = {
        let btn = UIButton()
        btn.setImage(.blogIconTistory, for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    // 자기 소개
    private let introduceView = SooInfoView(title: "자기소개", content: "")
    
   // 커스텀 스택뷰
    public let contentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 15
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // emptyView
    private let emptyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    
        setSubView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView(){
        [
            scrollView,
        ].forEach{self.addSubview($0)}
        
        scrollView.addSubview(contentView)
        
        [
            profileImageView,
            gradientView,
            userInfoLabel,
            mbtiLabel,
            gitButton,
            blogButton,
            introduceView,
            contentStackView,
            emptyView
        ].forEach{contentView.addSubview($0)}
    }
    
    private func setUI() {
        NSLayoutConstraint.activate([

            // 스크롤뷰
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            // 컨텐츠뷰
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            
            // 프로필 이미지 뷰
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            profileImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: 400),
            
            // 그라이데이션 뷰
            gradientView.topAnchor.constraint(equalTo: userInfoLabel.topAnchor, constant: -20),
            gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: mbtiLabel.bottomAnchor, constant: 10),
//            gradientView.heightAnchor.constraint(equalToConstant: 100),
            
            // 유저 정보 라벨
            userInfoLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: -75),
            userInfoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            userInfoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 16),
            userInfoLabel.heightAnchor.constraint(equalToConstant: 30),

            // MBTI
            mbtiLabel.topAnchor.constraint(equalTo: userInfoLabel.bottomAnchor, constant: 10),
            mbtiLabel.leadingAnchor.constraint(equalTo: userInfoLabel.leadingAnchor),
            mbtiLabel.heightAnchor.constraint(equalToConstant: 30),
            
            // 깃 버튼
//            gitButton.centerYAnchor.constraint(equalTo: mbtiLabel.centerYAnchor),
            gitButton.bottomAnchor.constraint(equalTo: gradientView.bottomAnchor, constant: -15),
            gitButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            gitButton.heightAnchor.constraint(equalToConstant: self.linkButtonWidthHeight),
            gitButton.widthAnchor.constraint(equalToConstant: self.linkButtonWidthHeight),
            
            // 블로그 버튼
            blogButton.centerYAnchor.constraint(equalTo: gitButton.centerYAnchor),
            blogButton.trailingAnchor.constraint(equalTo: gitButton.leadingAnchor, constant: -16),
            blogButton.heightAnchor.constraint(equalToConstant: self.linkButtonWidthHeight),
            blogButton.widthAnchor.constraint(equalToConstant: self.linkButtonWidthHeight),
            
            // 자기 소개
            introduceView.topAnchor.constraint(equalTo: gradientView.bottomAnchor, constant: 25),
            introduceView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            introduceView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
//            introduceView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // 커스텀 정보 뷰
            contentStackView.topAnchor.constraint(equalTo: introduceView.bottomAnchor, constant: 15),
            contentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
//            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            emptyView.topAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: 15),
            emptyView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            emptyView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            emptyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            emptyView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    public func config(user: User) {
        if let imagePathURL = user.imagePathURL {
            profileImageView.kf.setImage(with: URL(string: imagePathURL))
        } else {
            print("이미지 없음")
        }
        
        let age = Int(user.age ?? 0)
        userInfoLabel.text = "\(user.nickname ?? "") / \(user.name ?? "") (\(age)세)"
        mbtiLabel.text = user.mbti
        
        if let introduce = user.introduce {
            introduceView.config(title: "자기소개", content: introduce)
        }
        
        if let contents = user.contents {
            contents.forEach({ content in
                guard let title = content.title, let content = content.content else {
                    return
                }
                let infoView = SooInfoView(title: title, content: content)
                contentStackView.addArrangedSubview(infoView)
            })
        }
    }

}
