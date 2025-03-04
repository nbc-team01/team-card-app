//
//  CreateMemberCardViewControllelr.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/4/25.
//

import UIKit

class CreateMemberCardViewControllelr: UIViewController {
    private let createMemberCardView = CreateMemberCardView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = createMemberCardView
    }
}
