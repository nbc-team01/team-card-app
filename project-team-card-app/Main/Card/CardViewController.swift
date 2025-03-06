//
//  CardViewController.swift
//  project-team-card-app
//
//  Created by 양원식 on 3/6/25.
//
import UIKit
import SnapKit

// MARK: - Card View Controller
class CardViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let label = UILabel()
        label.text = "카드 화면"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
