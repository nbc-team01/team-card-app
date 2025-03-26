//
//  SplashViewController.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/7/25.
//

import UIKit

//MARK: 스플래시 뷰
class SplashViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
    }
    //MARK: 이미지 속성 설정 후 VC이동
    private func configure() {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")!
        imageView.contentMode = .scaleAspectFit
        imageView.frame.size = CGSize(width: 200, height: 200)
        imageView.center = view.center
        view.addSubview(imageView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.showMainView()
        }
    }
    //MARK: VC 네비게이션 설정
    private func showMainView() {
        let mainVC = TabBarView()
        mainVC.modalPresentationStyle = .fullScreen
        mainVC.modalTransitionStyle = .crossDissolve
        present(mainVC, animated: true)
    }
}
