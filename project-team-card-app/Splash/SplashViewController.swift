//
//  SplashViewController.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/7/25.
//

import UIKit

class SplashViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
    }
    
    private func configure() {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")!
        imageView.contentMode = .scaleAspectFit
        imageView.frame.size = CGSize(width: 200, height: 200)
        imageView.center = view.center
        view.addSubview(imageView)
    }
}
