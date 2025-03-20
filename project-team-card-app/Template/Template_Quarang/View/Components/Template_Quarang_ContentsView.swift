//
//  Template_Quarang_ContentsView.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/6/25.
//

import UIKit
import SnapKit

class Template_Quarang_ContentsView:UIView{
    
    var contents:[Content] = []
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()
    private func createItemView(title: String, content: String) -> UIStackView {
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 25)
        titleLabel.textAlignment = .left
        
        let contentLabel = UILabel()
        contentLabel.text = content
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = .byWordWrapping
        contentLabel.textAlignment = .left
        contentLabel.sizeToFit()
        
        let contentContainerView = UIView()
        contentContainerView.addSubview(contentLabel)
        
        contentLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15) // contentLabel에 padding을 20씩 적용
        }
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel,contentContainerView])
        stackView.axis = .vertical
        return stackView
    }
    init(contents:[Content]){
        super.init(frame: .zero)
        self.contents = contents
        configureView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureView(){
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        
        contents.forEach { item in
            let containerView = createItemView(title: item.title ?? "", content: item.content?.replacingOccurrences(of: "\\n", with: "\n") ?? "")
            stackView.addArrangedSubview(containerView)
        }
    }
}

#Preview{
    Template_Quarang_ViewController(userId:"UUID")
}
