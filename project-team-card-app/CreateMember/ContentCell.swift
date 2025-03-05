//
//  ContentCell.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/4/25.
//

import UIKit

class ContentCell: UITableViewCell {
    static let id = "ContentCell"
    
    // 타이틀 뷰
    public let titleView = CreateMemberInfoView(title: "Title", placeholder: "Enter your Content Title", isEnableRemove: true)
    
    // 컨텐츠 뷰
    public let contentsView = CreateMemberInfoView(title: "Content", placeholder: "Enter your Content", isLongText: true)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
//        self.contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
        setSubView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.titleView.removeButton.removeTarget(self, action: .none, for: .allEvents)
        self.titleView.textField.text = nil
        self.contentsView.textView.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
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
