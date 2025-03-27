//
//  UserCardOption.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/17/25.
//

import Foundation

//MARK: 카드 수정/삭제 케이스 
public enum UserCardOption {
    case create
    case modify(userId: String)
}
