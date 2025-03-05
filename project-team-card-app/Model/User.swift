//
//  User.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/4/25.
//

import Foundation

//User Data
struct User: Codable {
    var userID, name, mbti, nickname: String?
    var age: Int?
    var gitHubPathURL, blogPathURL: String?
    var introduce: String?
    var contents: [Content]?
    var password: String?
    var imagePathURL: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case name
        case mbti = "MBTI"
        case nickname, age
        case gitHubPathURL = "gitHub_path_URL"
        case blogPathURL = "blog_path_URL"
        case introduce, contents, password
        case imagePathURL = "image_path_URL"
    }
    
    init(userID: String? = nil, name: String? = nil, mbti: String? = nil, nickname: String? = nil, age: Int? = nil, gitHubPathURL: String? = nil, blogPathURL: String? = nil, introduce: String? = nil, contents: [Content]? = nil, password: String? = nil, imagePathURL: String? = nil) {
        self.userID = userID
        self.name = name
        self.mbti = mbti
        self.nickname = nickname
        self.age = age
        self.gitHubPathURL = gitHubPathURL
        self.blogPathURL = blogPathURL
        self.introduce = introduce
        self.contents = contents
        self.password = password
        self.imagePathURL = imagePathURL
    }
}

