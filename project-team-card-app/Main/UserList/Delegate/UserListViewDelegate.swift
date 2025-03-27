//
//  UserListProtocol.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/15/25.
//

import Foundation

//MARK: Deleagate - 컬렉션 뷰 아이템 터치 이벤트
protocol UserListViewDelegate: AnyObject {
    func didSelectUser(userId: String)
}
