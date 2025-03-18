//
//  CreateUserCardViewController.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/4/25.
//

import UIKit

class CreateUserCardViewController: ImagePickerViewController {
    
    //MARK: 저장 프로퍼티
    private let createUserCardView = CreateUserCardView()
    private let type: UserCardOption // 생성인지 수정인지 구분
    private var userId: String? // 수정일 때는 userId로 업데이트'// 필수 데이터가 모두 들어갔는지 확인
    
    //MARK: 연산 프로퍼티 및 반환값이 있는 메서드
    //유저 생성 페이지에 빈 입력 값을 검사하는 연산 프로퍼티
    //없을 경우 true 있을 경우 fasle를 반환
    private var validationData:Bool {
        let isImageValid = createUserCardView.imageView.image != UIImage(systemName: "photo.badge.plus")
        createUserCardView.errorLabel.isHidden = isImageValid
        let isInfoValid = createUserCardView.infoStackView.arrangedSubviews
            .compactMap { $0 as? CreateUserInfoView }
            .map { infoView -> Bool in
                let isValid = infoView.isLongText
                ? !infoView.textView.text.isEmpty : !(infoView.textField.text?.isEmpty ?? true)
                infoView.errorLabel.isHidden = isValid
                return isValid
            }
            .allSatisfy { $0 }
        return isImageValid && isInfoValid
    }
    // User 객체  생성 후 반환
    private func getUser(userId: String, password: String, imagePath: String) -> User {
        var user = User()
        user.userID = userId
        user.name = self.createUserCardView.nameView.textField.text
        user.mbti = self.createUserCardView.mbtiView.textField.text
        user.age = Int(self.createUserCardView.ageView.textField.text ?? "")
        user.nickname = self.createUserCardView.nicknameView.textField.text
        user.gitHubPathURL = self.createUserCardView.gitAddress.textField.text
        user.blogPathURL = self.createUserCardView.blogAddress.textField.text
        user.introduce = self.createUserCardView.introduceView.textView.text
        user.contents = createUserCardView.contentStackView.arrangedSubviews
            .compactMap { $0 as? ContentView }
            .compactMap { view in
                let id = UUID().uuidString
                guard let title = view.titleView.textField.text, !title.isEmpty,
                      let content = view.contentsView.textField.text, !content.isEmpty else { return nil }
                return Content(contentsId: id,title: title,content: content)
            }
        return user
    }
    //MARK: 생성자 및 초기 설정 메서드
    init(type: UserCardOption) {
        self.type = type
        super.init(imagePickerView: createUserCardView)
        fetchUserInfo()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view = createUserCardView
        setAction()
    }
    //MARK: 비즈니스 로직
    // 수정 시 정보 불러오기
    private func fetchUserInfo() {
        switch type {
        case .create: return
        case let .modify(userId):
            Task {
                do {
                    let user = try await UserAPIService.fetchUser(userId: userId)
                    self.userId = user.userID
                    DispatchQueue.main.async {
                        self.createUserCardView.config(user: user)
                        self.setUserContents(user: user)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    // 비밀 번호 확인
    private func checkPassword(password: String){
        guard let userId = self.userId else { return }
        Task {
            // 비밀번호 검사 성공
            if try await UserAPIService.isValidPassword(userId: userId, password: password){
                self.setUserData(password: password, mode: .modify(userId: userId))
            } else {
                let alert = UIAlertController(title: "비밀번호 확인", message: "비밀번호가 일치하지 않습니다.", preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true)
            }
        }
    }
    // 유저정보 생성/수정 요청
    private func setUserData(password: String,mode:UserCardOption){
        guard let userId = self.userId,let image = self.createUserCardView.imageView.image else {return}
        
        Task {
            let imagePath = try await StorageAPIService.setImage(image, userId: userId)
            let user = self.getUser(userId: userId, password: password, imagePath: imagePath)
            
            switch mode{
            case .create: try await UserAPIService.setUser(user: user)
            case .modify: try await UserAPIService.updateUser(user: user)
            }
            
            dismiss(animated: true)
        }
    }
    
    //MARK: UI 관련
    //수정 시 컨텐츠뷰 추가 로직
    private func setUserContents(user: User) {
        user.contents?.forEach {
            let contentView = ContentView()
            contentView.config(content: $0)
            
            let gesture = ContentDeleteGesture(target: self, action: #selector(removeButtonTapGesture))
            gesture.id = contentView.id
            contentView.titleView.removeButton.addGestureRecognizer(gesture)
            
            createUserCardView.contentStackView.addArrangedSubview(contentView)
        }
    }
    // 비밀번호 얼럿
    private func presentAlert(completion: @escaping (String) -> Void) {
        let alert = UIAlertController(title: "비밀번호를 입력해주세요", message: nil, preferredStyle: .alert)
        alert.addTextField()
        alert.textFields?.first?.isSecureTextEntry = true
        
        let cancelAction = UIAlertAction(title: "취소", style: .destructive)
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            let password = alert.textFields?.first?.text ?? ""
            completion(password) // 입력된 비밀번호 전달
        }
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        // 모델 생성 후 통신 처리
        present(alert, animated: true)
    }
    //MARK: 상세페이지 타겟설정
    //Add/Cancel 버튼
    //Add Content 버튼
    //터치 시 키보드 비홀성호 버튼
    private func setAction(){
        createUserCardView.addContentButton.addTarget(self, action: #selector(addContentButtonTarget), for: .touchUpInside)
        createUserCardView.saveButton.addTarget(self, action: #selector(saveButtonTarget), for: .touchUpInside)
        createUserCardView.cancelButton.addTarget(self, action: #selector(canecelButtonTarget), for: .touchUpInside)
        createUserCardView.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing)))
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //MARK: 버튼 이벤트
    @objc private func saveButtonTarget() {
        guard self.validationData else { return }
        // 얼럿 띄우기
        presentAlert{ password in
            switch self.type {
            case .create:
                self.setUserData(password: password, mode: .create)
                self.dismiss(animated: true)
            case .modify:
                self.checkPassword(password: password)
            }
        }
    }
    @objc private func canecelButtonTarget() {
        dismiss(animated: true)
    }
    @objc private func addContentButtonTarget() {
        // ContentView 생성
        let contentView = ContentView()
        let gesutre = ContentDeleteGesture(target: self, action: #selector(removeButtonTapGesture(_:)))
        gesutre.id = contentView.id
        contentView.titleView.removeButton.addGestureRecognizer(gesutre)
        createUserCardView.contentStackView.addArrangedSubview(contentView)
        createUserCardView.scrollView.scroll(to: .bottom)
    }
    @objc private func removeButtonTapGesture(_ gesture: ContentDeleteGesture) {
        guard let id = gesture.id else { return }
        createUserCardView.contentStackView.arrangedSubviews
            .compactMap{$0 as? ContentView }
            .filter{ $0.id == id }
            .forEach{ view in
                UIView.animate(withDuration: 0.3,animations: { view.alpha = 0 }){ _ in
                    view.removeFromSuperview()
                }
            }
    }
}

#Preview{
    CreateUserCardViewController(type: .create)
}
