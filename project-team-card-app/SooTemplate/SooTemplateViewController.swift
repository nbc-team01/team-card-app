//
//  SooTemplateViewController.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/4/25.
//

import UIKit

class SooTemplateViewController: UIViewController {
    private let templateView = SooTemplateView()
    private let dummyData = [
        (title: "123", content: "123123"),
        (title: "123", content: "123123"),
        (title: "123", content: "123123"),
        (title: "123", content: "123123"),
        (title: "123", content: "123123"),
        (title: "123", content: "123123"),
        (title: "123", content: "123123"),
    ]
    private let userDummyDaya: [Any] = ["고니", "이수현", 26, "ISTJ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = templateView
        setInfoData()
        setAction()
    }
    
    private func setInfoData() {
        dummyData.forEach{templateView.setInfoData(infoData: $0)}
        templateView.setUserInfoData(nickname: userDummyDaya[0] as! String, name: userDummyDaya[1] as! String, age: userDummyDaya[2] as! Int, mbti: userDummyDaya[3] as! String)
    }
    
    private func setAction() {
        
        // 임시로 수정 / 생성 로직 테스트
        templateView.editButton.addTarget(self, action: #selector(goToCreateMember), for: .touchUpInside)
        templateView.deleteButton.addTarget(self, action: #selector(goToModifyMember), for: .touchUpInside)
    }
    
    @objc private func goToCreateMember(){
        let nextVC = CreateMemberCardViewController(type: .create)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func goToModifyMember(){
        let nextVC = CreateMemberCardViewController(type: .modify(userId: "CEA20844-8180-4F35-873D-834283863213"))
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
