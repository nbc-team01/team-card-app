//
//  HeaderViewController.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/6/25.
//

import UIKit
import SnapKit

class TemplateHeaderViewController: UIViewController {
    
    var userId:String
    let headerView = TemplateHeaderView()
    let options = TemplateOption.allCases
    var option:TemplateOption = .soo
    private let pickerView = UIPickerView()
    private lazy var containerView = UIView()
    
    init(userId:String){
        self.userId = userId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureView()
    }
    private func configureView(){
        containerView = Template_Quarang_ViewController(userId: userId).view
        
        view.addSubview(containerView)
        view.addSubview(headerView)
        
        headerView.changeTemplateButton.addTarget(self, action: #selector(setupPicker), for: .touchUpInside)
        headerView.menuButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        headerView.dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        
        headerView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(headerView.divider.snp.bottom)
        }
        containerView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    @objc func showAlert() {
        let alertController = UIAlertController(title: "Please select option", message: nil, preferredStyle: .alert)
        
        let editAction = UIAlertAction(title: "수정", style: .default) { _ in
            let vc = CreateUserCardViewController(type: .modify(userId: self.userId))
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
            Task{
                try await UserAPIService.deleteUser(userId: self.userId)
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
        self.navigationController?.popViewController(animated: true)
    }
    @objc private func setupPicker() {
        let alertController = UIAlertController(title: "옵션 선택", message: nil, preferredStyle: .actionSheet)
        
        TemplateOption.allCases.forEach { option in
            let action = UIAlertAction(title: option.rawValue, style: .default) { _ in
                self.option = option
                self.updateContainerView()
            }
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    @objc func changeTemplateButtonTapped(){
        view.endEditing(true)
        updateContainerView()
    }
    
    private func updateContainerView() {
        containerView.subviews.forEach { $0.removeFromSuperview() }
        
        var newViewController: UIViewController
        
        switch option {
        case .soo:
            newViewController = SooTemplateViewController(userId: userId)
        case .hakyung:
            newViewController = HakyungTemplateViewController()
        case .wonsik:
            newViewController = WonsikTemplateViewController()
        case .quarang:
            newViewController = Template_Quarang_ViewController(userId: userId)
        }
        
        addChild(newViewController)
        newViewController.view.frame = containerView.bounds
        containerView.addSubview(newViewController.view)
        newViewController.didMove(toParent: self)
    }
}
#Preview{
    TemplateHeaderViewController(userId: "UUID")
}


