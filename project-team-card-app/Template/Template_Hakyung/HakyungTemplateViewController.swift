//
//  HakyungTemplateViewController.swift
//  project-team-card-app
//
//  Created by kingj on 3/6/25.
//

import UIKit

class HakyungTemplateViewController: UIViewController {
    
    private let templateView = HakyungTemplateView()
    
    override func loadView() {
        super.loadView()
        view = templateView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


#Preview(traits: .defaultLayout, body: {
    HakyungTemplateView()
})
