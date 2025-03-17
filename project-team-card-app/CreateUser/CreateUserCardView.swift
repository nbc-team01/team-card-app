//
//  CreateUserCardView.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/4/25.
//

import UIKit
import Kingfisher
import SnapKit


class CreateUserCardView: UIView {
    // 컨텐츠 뷰
    private let contentView = UIView()
    // 커스텀 내용 추가
    public let addContentButton = AddButton(type: .normal,text: "Add Content",buttonColor: .black,themeColor: .white)
    //cancel
    public let cancelButton = AddButton(type: .border,text: "Cancel",buttonColor: .white,themeColor: .black)
    //add
    public let saveButton = AddButton(type: .normal,text: "Add",buttonColor: .black,themeColor: .white)
    // 이름
    public let nameView = CreateUserInfoView(title: "이름", placeholder: "Enter your name")
    // MBTI
    public let mbtiView = CreateUserInfoView(title: "MBTI", placeholder: "Enter your MBTI")
    // 닉네임
    public let nicknameView = CreateUserInfoView(title: "닉네임", placeholder: "Enter your Nickname")
    // 깃허브
    public let gitAddress = CreateUserInfoView(title: "GitHub URL", placeholder: "Enter your Github URL")
    // 블로그
    public let blogAddress = CreateUserInfoView(title: "Blog URL", placeholder: "Enter your Blog URL")
    // 자기소개
    public let introduceView = CreateUserInfoView(title: "자기소개", placeholder: "Introduce yourself", isLongText: true)
    // 나이
    public let ageView: CreateUserInfoView = {
        let view = CreateUserInfoView(title: "나이", placeholder: "Enter your Age")
        view.textField.keyboardType = .numberPad // 숫자 패드로 변경
        return view
    }()
    // 타이틀 라벨
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "User Profile"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    // 경계션
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4.withAlphaComponent(0.5)
        return view
    }()
    // 스크롤뷰
    public let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
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
        return view
    }()
    // 에러 라벨
    public let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "프로필 사진을 선택해주세요"
        label.textColor = .red
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // 정보 스택뷰
    public let infoStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 15
        view.distribution = .fillProportionally
        return view
    }()
    // 컨텐츠 스택뷰
    public let contentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.distribution = .fillEqually
        return view
    }()
    // 바텀 버튼 스택뷰
    private let bottomButtonStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillEqually
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        isUserInteractionEnabled = true
        setSubView()
        setUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setSubView(){
        scrollView.addSubview(contentView)
        [titleLabel, divider, scrollView,bottomButtonStackView]
            .forEach{ addSubview($0) }
        [imageView, errorLabel, infoStackView, contentStackView, addContentButton]
            .forEach{ contentView.addSubview($0) }
        [cancelButton,saveButton]
            .forEach{ bottomButtonStackView.addArrangedSubview($0) }
        [nameView,mbtiView,ageView,nicknameView,gitAddress,blogAddress,introduceView]
            .forEach{ infoStackView.addArrangedSubview($0) }
    }
    
    private func setUI() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        divider.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.bottom.equalTo(bottomButtonStackView.snp.top)
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.width.equalToSuperview()
            make.height.equalTo(256)
        }
        errorLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom)
        }
        infoStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(errorLabel.snp.bottom)
        }
        contentStackView.snp.makeConstraints { make in
            make.top.equalTo(infoStackView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
        }
        addContentButton.snp.makeConstraints { make in
            make.top.equalTo(contentStackView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(contentView).offset(-10)
        }
        bottomButtonStackView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-10)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
    }
    
    public func config(user: User) {
        imageView.kf.setImage(with: URL(string: user.imagePathURL ?? ""))
        nameView.textField.text = user.name
        mbtiView.textField.text = user.mbti
        ageView.textField.text = "\(user.age ?? 0)"
        nicknameView.textField.text = user.nickname
        gitAddress.textField.text = user.gitHubPathURL
        blogAddress.textField.text = user.blogPathURL
        introduceView.textView.text = user.introduce
        if !introduceView.textView.text.isEmpty{
            introduceView.textView.placeHolderLabel.isHidden = true
        }
        
    }
}
#Preview{
    CreateUserCardViewController(type: .modify(userId: "00978D33-1DD6-42F4-9C11-4B421A86AEF9"))
}

