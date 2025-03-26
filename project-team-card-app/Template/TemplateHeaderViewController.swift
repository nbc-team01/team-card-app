//
//  HeaderViewController.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/6/25.
//

import UIKit
import SnapKit

class TemplateHeaderViewController: UIViewController,CreateUserViewControllerDelegate {
    
    var userId:String
    let headerView = TemplateHeaderView()
    let options = TemplateOption.allCases
    var option:TemplateOption = .quarang
    
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
        configureTarget()
    }
    func didSetUser() {
        updateContainerView()
    }
    private func configureTarget(){
        headerView.changeTemplateButton.addTarget(self, action: #selector(setupPicker), for: .touchUpInside)
        headerView.menuButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        headerView.dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
    }
    private func configureView(){
        containerView = Template_Quarang_ViewController(userId: userId).view
        
        [containerView,headerView]
            .forEach{ view.addSubview($0) }
        
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
            vc.delegate = self
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
            Task{
                self.presentAlert {[weak self] password in
                    guard let self = self else { return }
                    self.checkPassword(password: password)
                }
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
            newViewController = HakyungTemplateViewController(userId: userId)
        case .wonsik:
            newViewController = WonsikTemplateViewController(userId:userId)
        case .quarang:
            newViewController = Template_Quarang_ViewController(userId: userId)
        }
        
        addChild(newViewController)
        newViewController.view.frame = containerView.bounds
        containerView.addSubview(newViewController.view)
        newViewController.didMove(toParent: self)
    }
    
    // 비밀번호 확인 후 삭제
    private func checkPassword(password: String){
        Task {
            // 비밀번호 검사 성공
            if try await UserAPIService.isValidPassword(userId: userId, password: password){
                try await UserAPIService.deleteUser(userId: self.userId)
                self.dismissButtonTapped()
            } else {
                let alert = UIAlertController(title: "비밀번호 확인", message: "비밀번호가 일치하지 않습니다.", preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true)
            }
        }
    }
    
    // 비밀번호 얼럿
    private func presentAlert(completion: @escaping (String) -> Void) {
        let alert = UIAlertController(title: "비밀번호를 입력해주세요", message: nil, preferredStyle: .alert)
        alert.addTextField()
        alert.textFields?.first?.isSecureTextEntry = true
        
        let cancelAction = UIAlertAction(title: "취소", style: .destructive)
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            let password = alert.textFields?.first?.text ?? ""
            completion(password) // 입력된 비밀번호 전달
        }
        
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        
        // 모델 생성 후 통신 처리
        present(alert, animated: true)
    }
}
#Preview{
    TemplateHeaderViewController(userId: "UUID")
}


