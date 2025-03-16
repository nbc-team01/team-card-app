//
//  UserListProtocol.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/15/25.
//

import Foundation

protocol UserListViewDelegate: AnyObject {
    func didSelectUser(userId: String)
}
