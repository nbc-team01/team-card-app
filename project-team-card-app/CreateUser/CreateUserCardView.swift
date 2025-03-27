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
    //MARK: 컨텐츠 뷰
    var contentView = UIView()
    //MARK: 이미지 피커
    public let imagePickerView = ImagePickerView()
    //MARK: 커스텀 내용 추가
    public let addContentButton = AddButton(type: .normal,text: "Add Content",buttonColor: .black,themeColor: .white)
    //MARK: cancel
    public let cancelButton = AddButton(type: .border,text: "Cancel",buttonColor: .white,themeColor: .black)
    //MARK: add
    public let saveButton = AddButton(type: .normal,text: "Add",buttonColor: .black,themeColor: .white)
    //MARK: 이름
    public let nameView = CreateUserInfoView(title: "이름", placeholder: "Enter your name")
    //MARK: MBTI
    public let mbtiView = CreateUserInfoView(title: "MBTI", placeholder: "Enter your MBTI")
    //MARK: 닉네임
    public let nicknameView = CreateUserInfoView(title: "닉네임", placeholder: "Enter your Nickname")
    //MARK: 깃허브
    public let gitAddress = CreateUserInfoView(title: "GitHub URL", placeholder: "Enter your Github URL")
    //MARK: 블로그
    public let blogAddress = CreateUserInfoView(title: "Blog URL", placeholder: "Enter your Blog URL")
    //MARK: 자기소개
    public let introduceView = CreateUserInfoView(title: "자기소개", placeholder: "Introduce yourself", isLongText: true)
    //MARK: 나이
    public let ageView: CreateUserInfoView = {
        let view = CreateUserInfoView(title: "나이", placeholder: "Enter your Age")
        view.textField.keyboardType = .numberPad // 숫자 패드로 변경
        return view
    }()
    //MARK: 인디케이터 스탤뷰
    public lazy var indicatorStackView:UIStackView = {
        let view = UIStackView(arrangedSubviews: [indicator,indicatorLabel])
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 5
        view.isHidden = true
        return view
    }()
    //MARK: 인디케이터 라벨
    private let indicatorLabel: UILabel = {
        let label = UILabel()
        label.text = "Saving .."
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    //MARK: 인디케이터 라벨
    public lazy var indicator:UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .white
        view.startAnimating()
        view.isHidden = false
        return view
    }()
    //MARK: 백그라운드
    public let backgorund:UIView = {
        let view = UIView()
        view.backgroundColor = .gray.withAlphaComponent(0.5)
        view.isHidden = true
        return view
    }()
    //MARK: 타이틀 라벨
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "User Profile"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    //MARK: 경계션
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4.withAlphaComponent(0.5)
        return view
    }()
    //MARK: 스크롤뷰
    public let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    //MARK: 에러 라벨
    public let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "프로필 사진을 선택해주세요"
        label.textColor = .red
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.isHidden = true
        return label
    }()
    //MARK: 정보 스택뷰
    public let infoStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 15
        view.distribution = .fillProportionally
        return view
    }()
    //MARK: 컨텐츠 스택뷰
    public let contentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.distribution = .fillEqually
        return view
    }()
    //MARK: 바텀 버튼 스택뷰
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
    //MARK: 뷰 추가
    private func setSubView(){
        scrollView.addSubview(contentView)
        [titleLabel, divider, scrollView,bottomButtonStackView,backgorund,indicatorStackView]
            .forEach{ addSubview($0) }
        [imagePickerView, errorLabel, infoStackView, contentStackView, addContentButton]
            .forEach{ contentView.addSubview($0) }
        [cancelButton,saveButton]
            .forEach{ bottomButtonStackView.addArrangedSubview($0) }
        [nameView,mbtiView,ageView,nicknameView,gitAddress,blogAddress,introduceView]
            .forEach{ infoStackView.addArrangedSubview($0) }
    }
    //MARK: 오토레이아웃 설정
    private func setUI() {
        backgorund.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
        indicatorStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalToSuperview().inset(16)
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
        imagePickerView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.width.equalToSuperview()
            make.height.equalTo(self.snp.width).inset(10)
        }
        errorLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(imagePickerView.snp.bottom)
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
            make.bottom.equalTo(keyboardLayoutGuide.snp.top).offset(-10)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
    }
    //MARK: 유저정보 업데이트 후 뷰에 적용
    public func config(user: User) {
        imagePickerView.imageView.contentMode = .scaleAspectFill
        imagePickerView.imageView.kf.setImage(with: URL(string: user.imagePathURL ?? ""))
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
//    CreateUserCardViewController(type: .modify(userId: "00978D33-1DD6-42F4-9C11-4B421A86AEF9"))
    CreateUserCardViewController(type: .create)
}

