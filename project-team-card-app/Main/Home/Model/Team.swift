//
//  TeamRule.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/13/25.
//

import Foundation
import UIKit

struct Team{
    let image:UIImage?
    let title:String
    let content:String
    
    init(image: String, title: String, content: String) {
        self.image = UIImage(named: image)
        self.title = title
        self.content = content
    }
}
