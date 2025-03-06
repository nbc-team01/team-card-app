//
//  Template_Quarang_View.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/6/25.
//

import UIKit
import SnapKit

class Template_Quarang_View:UIView{
    var userId:String
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView:UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()
    private var profileView:UIView?
    
    init(userId:String) {
        self.userId = userId
        super.init(frame: .zero)
        fetchUser()
        configureView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureView(){
        addSubview(scrollView)
        
        scrollView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        
        if let profileView{
            let stack : UIStackView = {
                let view = UIStackView(arrangedSubviews: [profileView])
                view.axis = .vertical
                return view
            }()
            stackView = stack
            scrollView.addSubview(stackView)
            stackView.snp.makeConstraints {
                $0.edges.width.equalToSuperview()
            }
        }
    }
    func fetchUser(){
        Task{
            let user = try await UserAPIService.fetchUser(userId: self.userId)
            
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                
                self.profileView?.removeFromSuperview()
                self.profileView = Template_Quarang_ProfileView(user: user)
                self.configureView()
            }
        }
    }
}

#Preview{
    Template_Quarang_ViewController(userId: "UUID")
}
