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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view = templateView
    }
    override func viewDidLoad() {
        templateView.headerView.menuButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        templateView.headerView.dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
    }
    @objc func changeTemplateButtonTapped(){
        //템플릿 변환
    }
    @objc func showAlert() {
        let alertController = UIAlertController(title: "Please select option", message: nil, preferredStyle: .alert)
        
        let editAction = UIAlertAction(title: "수정", style: .default) { _ in
            let vc = SooTemplateViewController()    //<- VC수정
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .coverVertical
            self.present(vc, animated: true)
        }
        
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
            Task{
                try await UserAPIService.deleteUser(userId: self.userId ?? "")
                self.dismissButtonTapped()
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(editAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    @objc func dismissButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
#Preview{
    Template_Quarang_ViewController(userId: "UUID")
}



