//
//  SooTemplateView.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/3/25.
//

import UIKit

class SooTemplateView: UIView {
    // 탑 버튼 크기 (편집, 삭제)
    private let topButtonWidthHeight: CGFloat = 30
    
    // 링크 버튼 크기 (깃, 블로그)
    private let linkButtonWidthHeight: CGFloat = 50
    
    // 수정 버튼
    public lazy var editButton: UIButton = {
        let btn = UIButton()
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "square.and.pencil")
        config.contentInsets = .zero
        btn.configuration = config
        btn.tintColor = .black

        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    // 삭제 버튼
    public lazy var deleteButton: UIButton = {
        let btn = UIButton()
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "trash.fill")
        config.contentInsets = .zero
        btn.configuration = config
        btn.tintColor = .black

        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
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
        imgView.image = .githubMark
        imgView.contentMode = .scaleAspectFit
//        imgView.layer.cornerRadius = 8
//        imgView.clipsToBounds = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    // 그라데이션 뷰
    private let gradientView: UIView = {
        let view = UIView()
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 150)
        layer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.2).cgColor,
            UIColor.black.withAlphaComponent(0.5).cgColor,
            UIColor.black.withAlphaComponent(0.7).cgColor
        ]
        view.layer.addSublayer(layer)
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
    
//    // 이름
//    private let nameLabel: UILabel = {
//        let lbl = UILabel()
//        lbl.text = "임시 이름"
//        lbl.textColor = .white
//        lbl.font = .systemFont(ofSize: 30, weight: .semibold)
//        lbl.translatesAutoresizingMaskIntoConstraints = false
//        return lbl
//    }()
//    
//    // 닉네임
//    private let nicknameLabel: UILabel = {
//        let lbl = UILabel()
//        lbl.text = "닉네임"
//        lbl.textColor = .white
//        lbl.font = .systemFont(ofSize: 30, weight: .semibold)
//        lbl.translatesAutoresizingMaskIntoConstraints = false
//        return lbl
//    }()
//    
//    // 나이
//    private let ageLabel: UILabel = {
//        let lbl = UILabel()
//        lbl.text = "26"
//        lbl.textColor = .white
//        lbl.font = .systemFont(ofSize: 30, weight: .semibold)
//        lbl.translatesAutoresizingMaskIntoConstraints = false
//        return lbl
//    }()
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
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    // 블로그 버튼
    public lazy var blogButton: UIButton = {
        let btn = UIButton()
        btn.setImage(.blogIcon, for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    // 자기 소개
    private let introduceView = SooInfoView(title: "자기소개")
    
   // 커스텀 스택뷰
    public let infoStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 15
        view.distribution = .fill
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
            editButton,
            deleteButton,
            scrollView,
        ].forEach{self.addSubview($0)}
        
        scrollView.addSubview(contentView)
        
        [
            profileImageView,
            gradientView,
            userInfoLabel,
//            nameLabel,
//            nicknameLabel,
//            ageLabel,
            mbtiLabel,
            gitButton,
            blogButton,
            introduceView,
            infoStackView
        ].forEach{contentView.addSubview($0)}
    }
    
    private func setUI() {
        NSLayoutConstraint.activate([
            // 삭제 버튼
            deleteButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            deleteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            deleteButton.widthAnchor.constraint(equalToConstant: topButtonWidthHeight),
            deleteButton.heightAnchor.constraint(equalToConstant: topButtonWidthHeight),
            
            // 수정버튼
            editButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            editButton.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -16),
            editButton.widthAnchor.constraint(equalToConstant: topButtonWidthHeight),
            editButton.heightAnchor.constraint(equalToConstant: topButtonWidthHeight),
            
            // 스크롤뷰
            scrollView.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 10),
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
            gradientView.bottomAnchor.constraint(equalTo: mbtiLabel.bottomAnchor, constant: 25),
            gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            gradientView.heightAnchor.constraint(equalToConstant: 150),
            
            // 유저 정보 라벨
            userInfoLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            userInfoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            userInfoLabel.heightAnchor.constraint(equalToConstant: 30),
            
//            // 닉네임
//            nicknameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
//            nicknameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
//            nicknameLabel.heightAnchor.constraint(equalToConstant: 30),
//            
//            // 이름
//            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
//            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
//            nameLabel.heightAnchor.constraint(equalToConstant: 30),
//            
            // MBTI
            mbtiLabel.topAnchor.constraint(equalTo: userInfoLabel.bottomAnchor, constant: 10),
            mbtiLabel.leadingAnchor.constraint(equalTo: userInfoLabel.leadingAnchor),
            mbtiLabel.heightAnchor.constraint(equalToConstant: 30),
            
            // 깃 버튼
            gitButton.centerYAnchor.constraint(equalTo: mbtiLabel.centerYAnchor),
            gitButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            gitButton.heightAnchor.constraint(equalToConstant: self.linkButtonWidthHeight),
            gitButton.widthAnchor.constraint(equalToConstant: self.linkButtonWidthHeight),
            
            // 블로그 버튼
            blogButton.centerYAnchor.constraint(equalTo: gitButton.centerYAnchor),
            blogButton.trailingAnchor.constraint(equalTo: gitButton.leadingAnchor, constant: -16),
            blogButton.heightAnchor.constraint(equalToConstant: self.linkButtonWidthHeight),
            blogButton.widthAnchor.constraint(equalToConstant: self.linkButtonWidthHeight),
            
            // 자기 소개
            introduceView.topAnchor.constraint(equalTo: gradientView.bottomAnchor, constant: 15),
            introduceView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            introduceView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
//            introduceView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // 커스텀 정보 뷰
            infoStackView.topAnchor.constraint(equalTo: introduceView.bottomAnchor, constant: 15),
            infoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            infoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            infoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    // 커스텀 데이터
    public func setInfoData(infoData: (title: String, content: String)) {
        let infoView = SooInfoView(title: infoData.title, content: infoData.content)
        
        infoStackView.addArrangedSubview(infoView)
    }
    
    // 유저 정보 데이터
    public func setUserInfoData(nickname: String, name: String, age: Int, mbti: String) {
        userInfoLabel.text = "\(nickname) / \(name) (\(age)세)"
        mbtiLabel.text = mbti
    }
}
