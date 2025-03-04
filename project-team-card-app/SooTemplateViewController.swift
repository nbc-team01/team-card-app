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
    }
    
    private func setInfoData() {
        dummyData.forEach{templateView.setInfoData(infoData: $0)}
        templateView.setUserInfoData(nickname: userDummyDaya[0] as! String, name: userDummyDaya[1] as! String, age: userDummyDaya[2] as! Int, mbti: userDummyDaya[3] as! String)
    }
}
