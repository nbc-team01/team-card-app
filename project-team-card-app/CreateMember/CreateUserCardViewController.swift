//
//  CreateUserCardViewController.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/4/25.
//

import UIKit

// 생성인지 수정인지 구분
public enum UserCardType {
    case create
    case modify(userId: String)
}

class CreateUserCardViewController: UIViewController {
    private let createUserCardView = CreateUserCardView()
//    private var contentViews: [UUID: ContentView] = [:]
    private let type: UserCardType // 생성인지 수정인지 구분
    private var userId: String? // 수정일 때는 userId로 업데이트
    
    init(type: UserCardType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
        
        switch type {
        case .create:
            return
        case .modify(let userId):
            // 정보 불러오기
            fetchUserInfo(userId: userId)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = createUserCardView
        setDelegate()
        setAction()
        keyboardHidetapGesture()

    }
    
    // 키보드 숨기는 탭 제스처 등록
    private func keyboardHidetapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        createUserCardView.addGestureRecognizer(tap)
    }
    
    private func setDelegate(){
        // 자기소개 텍스트뷰 딜리게이트
        createUserCardView.introduceView.textView.delegate = self
    }
    
    private func setAction(){
        // Add Content 버튼 액션
        createUserCardView.addContentButton.addTarget(self, action: #selector(touchUpInsideAddContentButton), for: .touchUpInside)
        
        // Save 버튼 액션
        createUserCardView.saveButton.addTarget(self, action: #selector(touchUpInsideSaveButton), for: .touchUpInside)
        
        // Cancel 버튼 액션
        createUserCardView.cancelButton.addTarget(self, action: #selector(touchUpInsideCancelButton), for: .touchUpInside)
        
        // 이미지 추가
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(showImagePickerForLibrary))
        createUserCardView.imageView.addGestureRecognizer(imageTapGesture)
    }
    
    // 수정 시 정보 불러오기
    private func fetchUserInfo(userId: String) {
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
    
    // 수정 시 컨텐츠뷰 추가 로직
    private func setUserContents(user: User) {
        user.contents?.forEach({ content in
            // ContentView 생성
            let contentView = ContentView()
            contentView.config(content: content)
            
            // 삭제 제스처 추가
            let removeButtonTapGesutre = CustomTapGesture(target: self, action: #selector(removeButtonTapGesture(_:)))
            
            // 탭 제스처에 id 값 추가
            removeButtonTapGesutre.id = contentView.id
            
            // 삭제 버튼에 삭제 제스처 추가
            contentView.titleView.removeButton.addGestureRecognizer(removeButtonTapGesutre)
            
            // 생성한 View, StackView에 추가
            createUserCardView.contentStackView.addArrangedSubview(contentView)
            
            // 딜리게이트 설정 (텍스트 뷰)
            contentView.contentsView.textView.delegate = self
        })
    }
    
    // Save 버튼 액션
    @objc private func touchUpInsideSaveButton() {
        // nil 값이 있는지 확인
        guard self.validationData() else { return }
        
        // 얼럿 띄우기
        presentAlert() {[weak self] password in
            Task {
                do {
                    try await self?.setUserData(password: password)
                    // 홈뷰로 돌아가기 (통신 이후)
                    self?.navigationController?.popViewController(animated: true)
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // API 통신
    private func setUserData(password: String) async throws {
        // 모델 만들어서 DB에 저장
        // 커스텀 컨텐츠 배열
        var customContents = [Content]()
        
        // API 저장 로직 처리
//        let userId = UUID().uuidString
        guard let image = self.createUserCardView.imageView.image,
              let name = self.createUserCardView.nameView.textField.text,
              let mbti = self.createUserCardView.mbtiView.textField.text,
              let ageText = self.createUserCardView.ageView.textField.text,
              let age = Int(ageText),
              let nickname = self.createUserCardView.nicknameView.textField.text,
              let gitAddress = self.createUserCardView.gitAddress.textField.text,
              let blogAddress = self.createUserCardView.blogAddress.textField.text,
              let introduce = self.createUserCardView.introduceView.textView.text
        else {
            return
        }

        // 커스텀 컨텐츠 데이터 (빈 값 제외)
        self.createUserCardView.contentStackView.arrangedSubviews.forEach { view in
            guard let title = (view as? ContentView)?.titleView.textField.text,
                  title != "",
                  let content = (view as? ContentView)?.contentsView.textView.text,
                  (view as? ContentView)?.contentsView.textView.textColor != .placeholderText, content != ""
            else { return }
            
            let customContent = Content(contentsId: UUID().uuidString, title: title, content: content)
            customContents.append(customContent)
        }
        
        print(password, name, mbti, age, nickname, gitAddress, blogAddress, introduce, customContents)
        
        // 수정일 때는 값이 있으니 그대로 사용, 없으면 새로 생성
        let userId = self.userId ?? UUID().uuidString
        let user = User(userID: userId,
                        name: name,
                        mbti: mbti,
                        nickname: nickname,
                        age: age,
                        gitHubPathURL: gitAddress,
                        blogPathURL: blogAddress,
                        introduce: introduce,
                        contents: customContents,
                        password: password)
    
        Task {
            switch type {
            case .create:
                do {
                    // 정보 저장 API
                    try await UserAPIService.setUser(user: user)
                    
                    // 이미지 저장 API
                    let imagePath = try await StorageAPIService.setImage(image, userId: userId)
                    print("이미지 저장 성공: \(imagePath)")
                }
                catch {
                    print(error.localizedDescription)
                }
            case .modify(let userId):
                do {
                    // 정보 수정 API
                    try await UserAPIService.updateUser(user: user)
                    
                    // 이미지 저장 API
                    let imagePath = try await StorageAPIService.setImage(image, userId: userId)
                    print("이미지 저장 성공: \(imagePath)")
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }
        
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // 비밀번호 얼럿
    private func presentAlert(completion: @escaping (String) -> Void) {
        let alert = UIAlertController(title: "비밀번호를 입력해주세요", message: nil, preferredStyle: .alert)
        alert.addTextField()
        
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
    
    // 필수 데이터가 모두 들어갔는지 확인
    private func validationData() -> Bool {
        var flag = true
        
        // 이미지룰 추가했는지 확인
        if createUserCardView.imageView.image == UIImage(systemName: "photo.badge.plus") {
            createUserCardView.errorLabel.isHidden = false
            flag = false
        } else {
            createUserCardView.errorLabel.isHidden = true
        }
        
        // 기본 정보뷰를 돌면서 nil 데이터가 있는지 확인
        createUserCardView.infoStackView.arrangedSubviews.forEach { view in
            guard let infoView = view as? CreateUserInfoView else {
                flag = false
                return
            }
            
            // 텍스트뷰를 사용하는 뷰
            if infoView.isLongText {
                guard infoView.textView.textColor != .placeholderText else {
                    infoView.errorLabel.isHidden = false
                    flag = false
                    return
                }
                infoView.errorLabel.isHidden = true
                
                // 텍스트필드를 사용하는 뷰
            } else {
                guard let info = infoView.textField.text, info != "" else {
                    infoView.errorLabel.isHidden = false
                    flag = false
                    return
                }
                infoView.errorLabel.isHidden = true
            }
        }
        return flag
    }
    
    // Cancel 버튼 액션
    @objc private func touchUpInsideCancelButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // Add Content 버튼 액션
    @objc private func touchUpInsideAddContentButton() {
        // ContentView 생성
        let contentView = ContentView()
//        let id = UUID() // 컨텐츠 ID 생성
//        contentViews[id] = contentView // 딕셔너리에 저장
        
        // 삭제 제스처 추가
        let removeButtonTapGesutre = CustomTapGesture(target: self, action: #selector(removeButtonTapGesture(_:)))
        
        // 탭 제스처에 id 값 추가
        removeButtonTapGesutre.id = contentView.id
        
        // 삭제 버튼에 삭제 제스처 추가
        contentView.titleView.removeButton.addGestureRecognizer(removeButtonTapGesutre)
        
        // 생성한 View, StackView에 추가
        createUserCardView.contentStackView.addArrangedSubview(contentView)
        
        // 딜리게이트 설정 (텍스트 뷰)
        contentView.contentsView.textView.delegate = self
        
        // 스크롤뷰 이동
        createUserCardView.scrollView.scroll(to: .bottom)
    }
    
    // ContentView 삭제 버튼 액션
    @objc private func removeButtonTapGesture(_ gesture: CustomTapGesture) {
        guard let id = gesture.id else { return } // 제스처에 저장된 ID 값 추출
        
        /*
        // 제스처의 ID와 동일한 ContentView를 딕셔너리에서 찾아 삭제 (서버 저장 시 순서 보장 X)
        if let removeView = contentViews[id] {
            // 0.4초 동안 view의 투명도를 0으로 만들고, 이후 뷰 삭제
            UIView.animate(withDuration: 0.4, animations: {
                removeView.alpha = 0
            }){ _ in
                removeView.removeFromSuperview()
            }
            
            // 컨텐츠 뷰 딕셔너리에 값 제거
            contentViews.removeValue(forKey: id)
        }
         */
        

        // ContentView의 내부 ID 사용 (순서 보장)
        // contentStackView를 순회하면서 제스처 ID와 같으면 뷰 삭제
        createUserCardView.contentStackView.arrangedSubviews.forEach{ view in
            if (view as? ContentView)?.id == id {
                UIView.animate(withDuration: 0.3, animations: {
                    view.alpha = 0
                }){ _ in
                    view.removeFromSuperview()
                }
            }
        }
    }
    
    
    // 이미지뷰 선택 액션
    @objc private func showImagePickerForLibrary() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.modalPresentationStyle = UIModalPresentationStyle.popover
        imagePickerController.allowsEditing = true

        self.present(imagePickerController, animated: true)
//        showImagePicker(sourceType: UIImagePickerController.SourceType.photoLibrary, imagePickerController: imagePicker.imagePickerController)
    }
}

// 텍스트뷰 딜리게이트
extension CreateUserCardViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .placeholderText {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = (textView as? CustomTextView)?.placeHolderText
            textView.textColor = .placeholderText
        }
    }
}


extension CreateUserCardViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: UIImagePickerControllerDelegate Method
    /// 이미지 피커 컨트롤러에서 이미지를 선택하거나 카메라 촬영을 완료했을 때 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        guard let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as? UIImage else {

            return
        }
        
        dismiss(animated: false) {
            // TODO: 본인 UIImageView에 맞게 변경
            // MARK: - 선택된 이미지를 UIImageView에 넣는 코드
            self.createUserCardView.imageView.image = image
        }
    }
    
    // MARK: - Utilities
    private func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
        return Dictionary(uniqueKeysWithValues: input.map { key, value in (key.rawValue, value) })
    }

    private func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
        return input.rawValue
    }
}
