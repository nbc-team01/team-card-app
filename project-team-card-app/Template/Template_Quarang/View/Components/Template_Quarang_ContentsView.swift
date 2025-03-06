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
        view.spacing = 20
        view.alignment = .fill
        return view
    }()
    private func createItemView(title: String, content: String) -> UIView {
       let containerView = UIView()
       
       let titleLabel = UILabel()
       titleLabel.text = title
       titleLabel.font = .boldSystemFont(ofSize: 25)
       titleLabel.textAlignment = .left
       
       let contentLabel = UILabel()
       contentLabel.text = content
       contentLabel.font = .systemFont(ofSize: 20)
       contentLabel.textAlignment = .left
       
       containerView.addSubview(titleLabel)
       containerView.addSubview(contentLabel)
       
       titleLabel.snp.makeConstraints {
           $0.top.left.right.equalToSuperview()
           $0.bottom.equalToSuperview().inset(60)
       }
       
       contentLabel.snp.makeConstraints {
           $0.left.right.equalToSuperview().inset(15)
           $0.top.equalTo(titleLabel.snp.bottom).inset(-10)
       }
       
       return containerView
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
            let containerView = createItemView(title: item.title ?? "", content: item.content ?? "")
            stackView.addArrangedSubview(containerView)
        }
    }
}
