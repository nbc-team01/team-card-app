//
//  Content.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/4/25.
//

import Foundation

//Content of User Data
//Key - title, Value - content
//ex - Goals, Merit, TMI
struct Content: Codable {
    let contentsId,title, content: String
    
    enum CodingKeys: String, CodingKey {
        case title,content
        case contentsId = "contents_id"
    }
}
