//
//  Template_Quarang_ViewController.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/6/25.
//

import UIKit
import SnapKit

class Template_Quarang_ViewController: UIViewController {
    
    var userId:String?
    lazy var templateView = Template_Quarang_View(userId: userId ?? "")
    
    init(userId:String) {
        self.userId = userId
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        view = templateView
    }
    
}
#Preview{
    Template_Quarang_ViewController(userId: "UUID")
}



