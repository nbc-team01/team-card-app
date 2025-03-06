//
//  CustomTapGesture.swift
//  project-team-card-app
//
//  Created by 이수현 on 3/5/25.
//

import UIKit

class CustomTapGesture: UITapGestureRecognizer {
    var id: UUID? // ContentView 제거를 위한 ID
    var openURL: String? // 깃허브, 블로그 URL
}
