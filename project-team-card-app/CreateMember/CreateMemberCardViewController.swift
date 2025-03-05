//
//  CreateMemberCardViewController.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/4/25.
//

import UIKit

class CreateMemberCardViewController: UIViewController {
    private let createMemberCardView = CreateMemberCardView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = createMemberCardView
        setDelegate()
        setAction()
    }
    
    private func setDelegate(){
        createMemberCardView.introduceView.textView.delegate = self
    }
    
    private func setAction(){
        // Add Content 버튼 액션
        createMemberCardView.addContentButton.addTarget(self, action: #selector(touchUpInsideAddContentButton), for: .touchUpInside)
        
        // Save 버튼 액션
        createMemberCardView.saveButton.addTarget(self, action: #selector(touchUpInsideSaveButton), for: .touchUpInside)
        
        // Cancel 버튼 액션
        createMemberCardView.cancelButton.addTarget(self, action: #selector(touchUpInsideCancelButton), for: .touchUpInside)
    }
    
    // Save 버튼 액션
    @objc private func touchUpInsideSaveButton() {
        // nil 값이 있는지 확인
        guard self.validationData() else { return }
        
        // 얼럿 띄우기
        presentAlert() { password in
            // 모델 만들어서 DB에 저장
            
            // 커스텀 컨텐츠 배열
            var customContents = [(String, String)]()
            
            // API 저장 로직 처리
            guard let name = self.createMemberCardView.nameView.textField.text,
                  let mbti = self.createMemberCardView.mbtiView.textField.text,
                  let age = self.createMemberCardView.ageView.textField.text,
                  let gitAddress = self.createMemberCardView.gitAddress.textField.text,
                  let blogAddress = self.createMemberCardView.blogAddress.textField.text,
                  let introduce = self.createMemberCardView.introduceView.textView.text
            else {
                return
            }

            // 커스텀 컨텐츠 데이터 (빈 값 제외)
            self.createMemberCardView.contentStackView.arrangedSubviews.forEach { view in
                guard let title = (view as? ContentView)?.titleView.textField.text,
                      title != "",
                      let content = (view as? ContentView)?.contentsView.textView.text,
                      (view as? ContentView)?.contentsView.textView.textColor != .placeholderText
                else { return }
                customContents.append((title, content))
            }
            
            print(password, name, mbti, age, gitAddress, blogAddress, introduce, customContents)
        }
        
        // 홈뷰로 돌아가기 (통신 이후)
        self.navigationController?.popToRootViewController(animated: true)
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
        
        // 기본 정보뷰를 돌면서 nil 데이터가 있는지 확인
        createMemberCardView.infoStackView.arrangedSubviews.forEach { view in
            guard let infoView = view as? CreateMemberInfoView else {
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
        // ContentView 생성 -> ID 생성
        let contentView = ContentView()
        
        // 삭제 제스처 추가
        let removeButtonTapGesutre = CustomTapGesture(target: self, action: #selector(removeButtonTapGesture(_:)))
        
        // 탭 제스처에 id 값 추가
        removeButtonTapGesutre.id = contentView.id
        
        // 삭제 버튼에 삭제 제스처 추가
        contentView.titleView.removeButton.addGestureRecognizer(removeButtonTapGesutre)
        
        // 생성한 View, StackView에 추가
        createMemberCardView.contentStackView.addArrangedSubview(contentView)
        
        // 딜리게이트 설정 (텍스트 뷰)
        contentView.contentsView.textView.delegate = self
        
        // 스크롤뷰 이동
        createMemberCardView.scrollView.scroll(to: .bottom)
    }
    
    // ContentView 삭제 버튼 액션
    @objc private func removeButtonTapGesture(_ gesture: CustomTapGesture) {
        guard let id = gesture.id else { return } // 제스처에 저장된 ID 값 추출
        
        // contentStackView를 순회하면서 제스처 ID와 같으면 뷰 삭제
        createMemberCardView.contentStackView.arrangedSubviews.forEach{ view in
            if (view as? ContentView)?.id == id {
                view.removeFromSuperview()
            }
        }
    }
}

// 텍스트뷰 딜리게이트
extension CreateMemberCardViewController: UITextViewDelegate {
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
