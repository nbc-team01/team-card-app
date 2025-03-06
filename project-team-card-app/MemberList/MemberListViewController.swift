//
//  MemberListViewController.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/6/25.
//

import UIKit

class MemberListViewController: UIViewController {
    private let memberListView = MemberListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = memberListView
    }
}
