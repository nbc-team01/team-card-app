//
//  CreateUserCardView.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/4/25.
//

import UIKit
import Kingfisher

class CreateUserCardView: UIView {
    // 네트워크 통신 인디게이터 뷰
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.startAnimating()
        indicator.isHidden = true
        indicator.center = self.center
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    // 네트워크 통신 시 백그라운드
    private var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground.withAlphaComponent(0.5)
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 경계션
    private let seperatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 스크롤뷰
    public let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 컨텐츠 뷰
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 사진 올리기 버튼뷰 -> 컴포넌트 완성되면 교체할 예정
    public let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "photo.badge.plus")
        view.tintColor = .black
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .systemGray5
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 에러 라벨
    public let errorLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "프로필 사진을 선택해주세요"
        lbl.textColor = .red
        lbl.font = .systemFont(ofSize: 10, weight: .medium)
        lbl.isHidden = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    // 정보 스택뷰
    public let infoStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 15
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 이름
    public let nameView = CreateUserInfoView(title: "이름", placeholder: "Enter your name")
    
    // MBTI
    public let mbtiView = CreateUserInfoView(title: "MBTI", placeholder: "Enter your MBTI")
    
    // 나이
    public let ageView: CreateUserInfoView = {
        let view = CreateUserInfoView(title: "나이", placeholder: "Enter your Age")
        view.textField.keyboardType = .numberPad // 숫자 패드로 변경
        
        return view
    }()
    
    // 닉네임
    public let nicknameView = CreateUserInfoView(title: "닉네임", placeholder: "Enter your Nickname")
    
    // 깃허브
    public let gitAddress = CreateUserInfoView(title: "GitHub URL", placeholder: "Enter your Github URL")
    
    // 블로그
    public let blogAddress = CreateUserInfoView(title: "Blog URL", placeholder: "Enter your Blog URL")
    
    // 자기소개
    public let introduceView = CreateUserInfoView(title: "자기소개", placeholder: "Introduce yourself", isLongText: true)
    
    // 컨텐츠 스택뷰
    public let contentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // 커스텀 내용 추가
    public let addContentButton = AddButton(type: .content)

    // 바텀 버튼 스택뷰
    private let bottomButtonStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // cancel 버튼
    public let cancelButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Cancel", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        btn.layer.cornerRadius = 8
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    // Save 버튼
    public let saveButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Save", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 8
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
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
            seperatorLine,
            scrollView,
            backgroundView,
            activityIndicator
        ].forEach{self.addSubview($0)}
        
        scrollView.addSubview(contentView)
        
        [
            imageView,
            errorLabel,
            infoStackView,
            contentStackView,
            addContentButton,
            bottomButtonStackView,
        ].forEach{contentView.addSubview($0)}
        
        [
            cancelButton,
            saveButton
        ].forEach{bottomButtonStackView.addArrangedSubview($0)}
        
        [
            nameView,
            mbtiView,
            ageView,
            nicknameView,
            gitAddress,
            blogAddress,
            introduceView,
        ].forEach{infoStackView.addArrangedSubview($0)}
    }
    
    private func setUI() {
        NSLayoutConstraint.activate([

            // 경계선
            seperatorLine.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            seperatorLine.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            seperatorLine.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            seperatorLine.heightAnchor.constraint(equalToConstant: 1),
            
            // 스크롤뷰
            scrollView.topAnchor.constraint(equalTo: seperatorLine.bottomAnchor, constant: 10),
            scrollView.bottomAnchor.constraint(equalTo: self.keyboardLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            // 컨텐츠 뷰
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // 사진 올리기 이미지뷰
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 256),
            
            // 에러 라벨
            errorLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 3),
            errorLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 5),
            errorLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            
            // infoStackView
            infoStackView.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 10),
            infoStackView.leadingAnchor.constraint(equalTo: errorLabel.leadingAnchor, constant: 12),
            infoStackView.trailingAnchor.constraint(equalTo: errorLabel.trailingAnchor, constant: -12),
            
            // 컨텐츠 스택 뷰
            contentStackView.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 10),
            contentStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            
            // 내용 추가 버튼
            addContentButton.topAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: 10),
            addContentButton.bottomAnchor.constraint(equalTo: bottomButtonStackView.topAnchor, constant: -10),
            addContentButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            addContentButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            addContentButton.heightAnchor.constraint(equalToConstant: 28),
            
            // 바텀 버튼
            bottomButtonStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            bottomButtonStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            bottomButtonStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            bottomButtonStackView.heightAnchor.constraint(equalToConstant: 42),
            
            // 인디게이터
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 50),
            activityIndicator.heightAnchor.constraint(equalToConstant: 50),
            
            // 백그라운드
            backgroundView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    public func config(user: User) {
        if let imagePathURL = user.imagePathURL {
            imageView.kf.setImage(with: URL(string: imagePathURL))
        }
        
        if let age = user.age {
            ageView.textField.text = "\(age)"
        }

        nameView.textField.text = user.name
        mbtiView.textField.text = user.mbti
        nicknameView.textField.text = user.nickname
        gitAddress.textField.text = user.gitHubPathURL
        blogAddress.textField.text = user.blogPathURL
        introduceView.textView.text = user.introduce
        introduceView.textView.textColor = .black
    }
    
    public func startIndicator(){
        self.activityIndicator.isHidden = false
        self.backgroundView.isHidden = false
    }
}
