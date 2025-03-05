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
    }
    
    private func setDelegate(){
        createMemberCardView.introduceView.textView.delegate = self
    }
}

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
