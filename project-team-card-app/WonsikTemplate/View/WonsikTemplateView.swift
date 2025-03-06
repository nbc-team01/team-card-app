//
//  WonsikTemplateView.swift
//  project-team-card-app
//
//  Created by 양원식 on 3/5/25.
//

import UIKit
import SnapKit
import Kingfisher

class WonsikTemplateView: UIView {
    
    //MARK: - UI 요소 정의
    
    // 스크롤 뷰 생성
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true // 세로 스크롤바 숨김
        return scrollView
    }()
    
    // 실제 UI를 담을 뷰
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    // 프로필 이미지
    private let profileImage: UIImageView = {
        let profile = UIImageView()
        profile.image = UIImage(systemName:"person") // 기본 이미지
        profile.contentMode = .scaleAspectFit
        return profile
    }()
    
    // 이름
    private let nameLabel: UILabel = {
        let name = UILabel()
        name.text = "이름 | 닉네임" // 추후 변경
        name.font = .systemFont(ofSize: 20, weight: .bold)
        return name
    }()
    
    // 나이
    private let ageLabel: UILabel = {
        let age = UILabel()
        age.text = "나이" // 추후 변경
        age.font = .systemFont(ofSize: 20, weight: .bold)
        age.textAlignment = .right
        return age
    }()
    
    // iOS 클래스
    private let iosClassLabel: UILabel = {
        let iosClass = UILabel()
        iosClass.text = "내배캠 iOS 마스터 6기"
        iosClass.font = .systemFont(ofSize: 14, weight: .bold)
        iosClass.textColor = .systemGray
        return iosClass
    }()
    
    // GitHub 버튼
    private let githubIcon: UIButton = {
        let github = UIButton()
        let iconImage = UIImage(named: "githubIcon")
        github.setImage(iconImage, for: .normal)
        return github
    }()
    
    // Tistory 버튼
    private let tistoryIcon: UIButton = {
        let tistory = UIButton()
        let iconImage = UIImage(named: "blogIcon-Tistory")
        tistory.setImage(iconImage, for: .normal)
        return tistory
    }()
    
    // About Me 섹션
    private let aboutMeSection = CustomSectionView(title: "About Me", content: "내용")
    
    // MBTI 섹션
    private let mbtiSection = CustomMbtiView(mbti: "ESFP")
    
    // Style 섹션
    private let styleSection = CustomSectionView(title: "Style", content: "내용")
    
    // Contents 섹션
    private var contentsSections: [CustomSectionView] = []
    
    //MARK: - 초가화 메서드
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI 구성 메서드
    private func setupUI() {
        backgroundColor = .white
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(profileImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(ageLabel)
        contentView.addSubview(iosClassLabel)
        contentView.addSubview(githubIcon)
        contentView.addSubview(tistoryIcon)
        contentView.addSubview(aboutMeSection)
        contentView.addSubview(mbtiSection)
        contentView.addSubview(styleSection)
        
        // 스크롤 뷰 설정
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // contentView 설정
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        // 프로필 이미지
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(400)
        }
        
        // 이름 레이블
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
        }
        
        // 나이 레이블
        ageLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(15)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        // iOS Class 레이블
        iosClassLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
        }
        
        // GitHub 버튼
        githubIcon.snp.makeConstraints { make in
            make.top.equalTo(ageLabel.snp.bottom).offset(15)
            make.trailing.equalToSuperview().offset(-60)
            make.width.height.equalTo(40)
        }
        
        // Tistory 버튼
        tistoryIcon.snp.makeConstraints { make in
            make.top.equalTo(ageLabel.snp.bottom).offset(15)
            make.leading.equalTo(githubIcon.snp.trailing).offset(5)
            make.width.height.equalTo(40)
        }
        
        // About Me 섹션
        aboutMeSection.snp.makeConstraints { make in
            make.top.equalTo(githubIcon.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        // About Me 섹션
        mbtiSection.snp.makeConstraints { make in
            make.top.equalTo(aboutMeSection.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        // Style 섹션
        styleSection.snp.makeConstraints { make in
            make.top.equalTo(mbtiSection.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
    }
    
    //MARK: - UI 업데이트 메서드
    // 프로필 정보 업데이트 메서드 수정
    func updateProfile(imageUrl: String?, name: String, age: String, githubURL: String?, blogURL: String?) {
        print("updateProfile 호출됨!")
        print("이미지 URL: \(imageUrl ?? "없음")")
        print("이름: \(name)")
        print("나이: \(age)")
        
        nameLabel.text = name
        ageLabel.text = age
        
        if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
            profileImage.kf.setImage(
                with: url,
                placeholder: UIImage(systemName: "person.fill"), // 기본 이미지 설정
                options: [
                    .transition(.fade(0.2)), // 부드럽게 이미지 전환
                    .forceRefresh // 캐시 강제 새로고침
                ],
                completionHandler: { result in
                    switch result {
                    case .success(let value):
                        print("이미지 로드 성공: \(value.source.url?.absoluteString ?? "")")
                    case .failure(let error):
                        print("이미지 로드 실패: \(error.localizedDescription)")
                        DispatchQueue.main.async {
                            self.profileImage.image = UIImage(systemName: "person.fill") // 기본 이미지 강제 적용
                        }
                    }
                }
            )
        } else {
            profileImage.image = UIImage(systemName: "person.fill") // 이미지 URL이 nil이면 기본 이미지 적용
        }
        
        githubIcon.addTarget(self, action: #selector(openGitHub), for: .touchUpInside)
        tistoryIcon.addTarget(self, action: #selector(openBlog), for: .touchUpInside)
        
        self.githubUrl = githubURL
        self.blogUrl = blogURL
    }
    
    
    
    /// About Me 및 Style 섹션 업데이트
    func updateSections(aboutMeTitle: String, aboutMeContent: String, mbti: String, styleTitle: String, styleContent: String, contents: [Content]?) {
        aboutMeSection.updateSection(title: aboutMeTitle, content: aboutMeContent)
        mbtiSection.updateSection(mbti: mbti)
        styleSection.updateSection(title: styleTitle, content: styleContent)
        updateContentsSections(contents: contents)
    }
    
    
    // Contents 섹션 업데이트
    func updateContentsSections(contents: [Content]?) {
        
        // Firebase에서 새로운 데이터를 가져올 때마다 contentsSections에 중복된 뷰가 추가되는 걸 방지하기 위해
        // 기존 뷰를 제거하지 않으면 같은 섹션이 계속 추가될 수 있음
        
        for section in contentsSections {
            section.removeFromSuperview()
        }
        contentsSections.removeAll()
        
        // 만약 User.contents 데이터가 없을 경우 불필요하게 빈 공간을 차지하지 않도록 하기 위해
        // return이 실행되면 아래 코드가 실행되지 않음
        guard let contents = contents, !contents.isEmpty else { return } // 내용이 없으면 아무것도 추가하지 않음
        
        
        // 새로운 CustomSectionView를 styleSection 바로 아래에 배치해야 하기 때문
        var lastView: UIView = styleSection // 마지막으로 배치된 뷰를 기준으로 새 섹션을 추가하기 위해 저장
        
        
        // lastView를 업데이트하지 않으면 모든 섹션이 같은 위치에 쌓이게 됨
        // make.top.equalTo(lastView.snp.bottom).offset(20)를 사용하면 이전 섹션 아래로 자동 배치됨
        for content in contents {
            let section = CustomSectionView(title: content.title ?? "제목 없음", content: content.content ?? "내용 없음")
            contentsSections.append(section)
            contentView.addSubview(section)
            
            section.snp.makeConstraints { make in
                make.top.equalTo(lastView.snp.bottom).offset(20)
                make.leading.trailing.equalToSuperview().inset(20)
            }
            
            lastView = section // 다음 섹션이 현재 섹션 아래에 배치되도록 설정
        }
        
        //contentView의 bottom이 지정되지 않으면 스크롤이 작동하지 않음
        // 마지막 섹션의 bottom이 contentView.bottom에 닿아야 스크롤 뷰가 정상 작동
        
        // 마지막으로 추가된 섹션의 bottom을 contentView의 bottom과 연결
        lastView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    
    //MARK: - 외부 URL 열기
    private var githubUrl: String?
    private var blogUrl: String?
    
    @objc private func openGitHub() {
        if let urlString = githubUrl, let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func openBlog() {
        if let urlString = blogUrl, let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
}
