//
//  CreateMemberCardView.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/4/25.
//

import UIKit

class CreateMemberCardView: UIView {
    // 상수 설정
    struct Constant {
        static let longTextFieldHeight: CGFloat = 200
        static let shortTextFieldHeight: CGFloat = 80
    }
    
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
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 이름
    public let nameView = CreateMemberInfoView(title: "이름")
    
    // 나이
    public let ageView = CreateMemberInfoView(title: "나이")
    
    // 깃허브
    public let gitAddress = CreateMemberInfoView(title: "GitHub 주소")
    
    // 블로그
    public let blogAddress = CreateMemberInfoView(title: "블로그 주소")
    
    // 자기소개
    public let introduceView = CreateMemberInfoView(title: "자기 소개")
    
    // 인증번호
    public let passwordView = CreateMemberInfoView(title: "인증번호", isSecurity: true)
    
    // 커스텀 내용 추가
    public let addContentButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("커스텀 필드 추가하기", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        btn.layer.cornerRadius = 8
        btn.backgroundColor = .systemCyan
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
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [
            infoStackView,
            addContentButton,
        ].forEach{contentView.addSubview($0)}
        
        [
            imageView,
            nameView,
            ageView,
            gitAddress,
            blogAddress,
            introduceView,
            passwordView
        ].forEach{infoStackView.addArrangedSubview($0)}
    }
    
    private func setUI() {
        NSLayoutConstraint.activate([
            // 스크롤뷰
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            // 컨텐츠 뷰
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // infoStackView
            infoStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            infoStackView.bottomAnchor.constraint(equalTo: addContentButton.topAnchor, constant: -20),
            infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // 내용 추가 버튼
            addContentButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            addContentButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            addContentButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            addContentButton.heightAnchor.constraint(equalToConstant: 60),
            
            // 사진 올리기 이미지뷰
            imageView.heightAnchor.constraint(equalToConstant: 400),
            
            // 이름
            nameView.heightAnchor.constraint(equalToConstant: Constant.shortTextFieldHeight),
            
            // 나이
            ageView.heightAnchor.constraint(equalToConstant: Constant.shortTextFieldHeight),
            
            // 깃허브
            gitAddress.heightAnchor.constraint(equalToConstant: Constant.shortTextFieldHeight),
            
            // 블로그
            blogAddress.heightAnchor.constraint(equalToConstant: Constant.shortTextFieldHeight),
            
            // 자기소개
            introduceView.heightAnchor.constraint(equalToConstant: Constant.longTextFieldHeight),
            
            // 패스워드
            passwordView.heightAnchor.constraint(equalToConstant: Constant.shortTextFieldHeight),
        ])
    }
}
