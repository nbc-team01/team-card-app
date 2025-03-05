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
//        lbl.layer.shadowOffset = CGSize(width: 0, height: 2)
//        lbl.layer.shadowOpacity = 0.12 // 12 투명도
//        lbl.layer.shadowColor = UIColor.black.cgColor
//        lbl.layer.shadowRadius = 6 // 블러
//        lbl.layer.masksToBounds = false
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
    
    // 커스텀 내용 추가
    public let addContentButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Add Content", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
        btn.layer.cornerRadius = 8
        btn.backgroundColor = .black
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
            scrollView
        ].forEach{self.addSubview($0)}
        
        scrollView.addSubview(contentView)
        
        [
            imageView,
            infoStackView,
            addContentButton,
        ].forEach{contentView.addSubview($0)}
        
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
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
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
            infoStackView.bottomAnchor.constraint(equalTo: addContentButton.topAnchor, constant: -20),
            infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            // 이름
//            nameView.heightAnchor.constraint(equalToConstant: Constant.shortTextFieldHeight),
//            
//            // MBTI
//            mbtiView.heightAnchor.constraint(equalToConstant: Constant.shortTextFieldHeight),
//            
//            // 나이
//            ageView.heightAnchor.constraint(equalToConstant: Constant.shortTextFieldHeight),
//            
//            // 깃허브
//            gitAddress.heightAnchor.constraint(equalToConstant: Constant.shortTextFieldHeight),
//            
//            // 블로그
//            blogAddress.heightAnchor.constraint(equalToConstant: Constant.shortTextFieldHeight),
//            
//            // 자기소개
//            introduceView.heightAnchor.constraint(equalToConstant: Constant.longTextFieldHeight),
//            
//            // 패스워드
//            passwordView.heightAnchor.constraint(equalToConstant: Constant.shortTextFieldHeight),
            
            
            // 내용 추가 버튼
            addContentButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            addContentButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            addContentButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            addContentButton.heightAnchor.constraint(equalToConstant: 28),
            
        ])
    }
}
