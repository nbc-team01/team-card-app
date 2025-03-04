//
//  SooTemplateViewController.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/4/25.
//

import UIKit

class SooTemplateViewController: UIViewController {
    private let templateView = SooTemplateView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = templateView
    }
}
