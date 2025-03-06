//
//  RootViewController.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/6/25.
//

import UIKit

class RootViewController: UIViewController {
    let userId = "UUID"
    let button: UIButton = {
        let btn = UIButton()
        btn.setTitle("버튼", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .green
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        button.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        
        view.backgroundColor = .white

    }
    
    @objc func btnAction() {
        Task {
            do {
                let user = try await UserAPIService.fetchUser(userId: userId)
                print(user)
                
                    let nextVC = SooTemplateViewController(user: user)
                    self.navigationController?.pushViewController(nextVC, animated: true)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
