//
//  HomeView.swift
//  project-team-card-app
//
//  Created by 양원식 on 3/6/25.
//

import UIKit
import SnapKit

//MARK: 홈뷰 VC
class HomeViewController: UIViewController {
    private let homeView = HomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = homeView
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

#Preview{
    HomeViewController()
}
