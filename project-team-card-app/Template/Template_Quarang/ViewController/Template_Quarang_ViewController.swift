//
//  Template_Quarang_ViewController.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/6/25.
//

import UIKit
import SnapKit

class Template_Quarang_ViewController: UIViewController {
    
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
    private let headerView = Template_Quarang_HeaderView()
    private var profileView:UIView?
    
    init(userId:String) {
        self.userId = userId
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        fetchUser()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureView()
    }
    func configureView(){
        view.addSubview(scrollView)
        view.addSubview(headerView)
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
        headerView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(headerView.divider.snp.bottom)
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



