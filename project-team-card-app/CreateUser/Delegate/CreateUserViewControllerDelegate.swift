//
//  CreateUserViewControllerDelegate.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/20/25.
//

import Foundation

//MARK: 유저정보가 세팅 된 후 이벤트
protocol CreateUserViewControllerDelegate:AnyObject{
    func didSetUser()
}
