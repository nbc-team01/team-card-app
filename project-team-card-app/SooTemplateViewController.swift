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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = templateView
        setInfoData()
    }
    
    private func setInfoData() {
        dummyData.forEach{templateView.setInfoData(infoData: $0)}
    }
}
