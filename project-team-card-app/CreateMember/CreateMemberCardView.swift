//
//  CreateMemberCardView.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/4/25.
//

import UIKit

class CreateMemberCardView: UIView {
    // 타이틀 라벨
    public let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "User Profile"
        lbl.font = .systemFont(ofSize: 20, weight: .medium)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    // 경계션
    private let seperatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 스크롤뷰
    private let scrollView: UIScrollView = {
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
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.image = .githubMark
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 정보 스택뷰
    private let infoStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 15
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 이름
    public let nameView = CreateMemberInfoView(title: "이름", placeholder: "Enter your name")
    
    // MBTI
    public let mbtiView = CreateMemberInfoView(title: "MBTI", placeholder: "Enter your MBTI")
    
    // 나이
    public let ageView = CreateMemberInfoView(title: "나이", placeholder: "Enter your Age")
    
    // 깃허브
    public let gitAddress = CreateMemberInfoView(title: "GitHub URL", placeholder: "Enter your Github URL")
    
    // 블로그
    public let blogAddress = CreateMemberInfoView(title: "Blog URL", placeholder: "Enter your Blog URL")
    
    // 자기소개
    public let introduceView = CreateMemberInfoView(title: "자기소개", placeholder: "Introduce yourself", isLongText: true)
    
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
    public let addContentButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Add Content", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
        btn.layer.cornerRadius = 8
        btn.backgroundColor = .black
        btn.isUserInteractionEnabled = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
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
            titleLabel,
            seperatorLine,
            scrollView,
        ].forEach{self.addSubview($0)}
        
        scrollView.addSubview(contentView)
        
        [
            imageView,
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
            gitAddress,
            blogAddress,
            introduceView,
        ].forEach{infoStackView.addArrangedSubview($0)}
    }
    
    private func setUI() {
        NSLayoutConstraint.activate([
            // titleLabel
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 48),
            
            // 경계선
            seperatorLine.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            seperatorLine.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            seperatorLine.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            seperatorLine.heightAnchor.constraint(equalToConstant: 1),
            
            // 스크롤뷰
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
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
            
            // infoStackView
            infoStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
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
        ])
    }
}
