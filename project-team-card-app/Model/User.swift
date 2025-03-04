//
//  User.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/4/25.
//

import Foundation

struct User: Codable {
    let userID, name, mbti, nickname: String
    let age: Int
    let gitHubPathURL, blogPathURL: String
    let introduce: String
    let contents: [Content]
    let password: String
    let imagePathURL: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case name
        case mbti = "MBTI"
        case nickname, age
        case gitHubPathURL = "gitHub_path_URL"
        case blogPathURL = "blog_path_URL"
        case introduce, contents, password
        case imagePathURL = "image_path_URL"
    }
}

