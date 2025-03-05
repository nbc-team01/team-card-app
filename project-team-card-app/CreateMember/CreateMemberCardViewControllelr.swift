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
        createMemberCardView.addContentButton.addTarget(self, action: #selector(touchUpInsideAddContentButton), for: .touchUpInside)
    }
    
    // Add Content 버튼 액션
    @objc private func touchUpInsideAddContentButton() {
        let contentView = ContentView() // ContentView 생성 -> ID 생성
        let removeButtonTapGesutre = CustomTapGesture(target: self, action: #selector(removeButtonTapGesture(_:))) // 삭제 제스처 추가
        removeButtonTapGesutre.id = contentView.id // 탭 제스처에 id 값 추가
        contentView.titleView.removeButton.addGestureRecognizer(removeButtonTapGesutre) // 삭제 버튼에 삭제 제스처 추가
        createMemberCardView.contentStackView.addArrangedSubview(contentView) // 생성한 View, StackView에 추가
        
        contentView.contentsView.textView.delegate = self // 딜리게이트 설정 (텍스트 뷰)
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

// 텍스트 필드 딜리게이트
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
