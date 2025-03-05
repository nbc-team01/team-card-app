//
//  ContentView.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/5/25.
//

import UIKit

class ContentView: UIView {
    public var id = UUID() // Content 구분을 위해 ID 값 사용
    
    // 타이틀 뷰
    public let titleView = CreateMemberInfoView(title: "Title", placeholder: "Enter your Content Title", isEnableRemove: true)
    
    // 컨텐츠 뷰
    public let contentsView = CreateMemberInfoView(title: "Content", placeholder: "Enter your Content", isLongText: true)
    
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
        [
            titleView,
            contentsView
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI() {
        NSLayoutConstraint.activate([
            // 타이틀 뷰
            titleView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            titleView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            // 컨텐츠 뷰
            contentsView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 8),
            contentsView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            contentsView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            contentsView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
