//
//  Template_Quarang_ViewController.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/6/25.
//

import UIKit
import SnapKit

class Template_Quarang_ViewController: UIViewController {
    
    private let headerView = Template_Quarang_HeaderView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        configureHeaderView()
    }
    func configureHeaderView(){
        view.addSubview(headerView)
        
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
    }
}
#Preview{
    Template_Quarang_ViewController()
}



