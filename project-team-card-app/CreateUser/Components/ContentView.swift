//
//  ContentView.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/5/25.
//

import UIKit
import SnapKit

class ContentView: UIView {
    public var id = UUID() // Content 구분을 위해 ID 값 사용
    
    // 타이틀 뷰
    public let titleView = CreateUserInfoView(title: "Title", placeholder: "Enter your Content Title",isContent: true)
    // 컨텐츠 뷰
    public let contentsView = CreateUserInfoView(title: "Content", placeholder: "Enter your Content", isLongText: true)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        setSubView()
        setUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setSubView() {
        [titleView,contentsView].forEach{ addSubview($0) }
    }
    private func setUI() {
        titleView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        contentsView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    func config(content: Content) {
        titleView.textField.text = content.title
        contentsView.textView.text = content.content
        if !contentsView.textView.text.isEmpty {
            contentsView.textView.placeHolderLabel.isHidden = true
        }
    }
}
#Preview{
    CreateUserCardViewController(type: .modify(userId: "00978D33-1DD6-42F4-9C11-4B421A86AEF9"))
//    CreateUserCardViewController(type: .create)
}
