//
//  CreateMemberCardViewController.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/4/25.
//

import UIKit

class CreateMemberCardViewController: UIViewController {
    private let createMemberCardView = CreateMemberCardView()
    private var contentsCount = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = createMemberCardView
        setDelegate()
    }
    
    private func setDelegate(){
        createMemberCardView.introduceView.textView.delegate = self
        createMemberCardView.contentTableView.dataSource = self
        createMemberCardView.contentTableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        createMemberCardView.updateContentTableViewHeight(contentCount: contentsCount)
    }
}

// 테이블 뷰 데이터소스
extension CreateMemberCardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentCell.id) as? ContentCell else { return UITableViewCell() }
//        cell.titleView.removeButton.addTarget(self, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        return cell
    }
}

// 테이블 뷰 딜리게이트
extension CreateMemberCardViewController: UITableViewDelegate {

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
