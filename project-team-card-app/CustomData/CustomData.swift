//
//  CustomData.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/4/25.
//

import Foundation

//singleton
class CustomData{
    static let shared = CustomData()
    private init(){}
    
    //user data
    var user:User{
        let user = """
        {
          "user_id": "UUID",
          "name": "John Doe",
          "MBTI": "INTJ",
          "nickname": "johnny",
          "age": 25,
          "gitHub_path_URL": "https://github.com/johndoe",
          "blog_path_URL": "https://youtube.com/johndoe",
          "introduce": "iOS Developer",
          "contents": [
            {
              "contents_id": "aaaaaaa",
              "title": "Project A",
              "content": "Description of Project A"
            },
            {
              "contents_id": "bbbbbbb",
              "title": "Project B",
              "content": "Description of Project B"
            }
          ],
          "password": "hashed_password",
          "image_path_URL": "https://example.com/profile.jpg"
        }
        """
        return try! JSONDecoder().decode(User.self, from: user.data(using: .utf8)!)
    }
    
    //user data list
    var userList:[User]{
        let user = """
        [
        {
          "user_id": "UUID",
          "name": "John Doe",
          "MBTI": "INTJ",
          "nickname": "johnny",
          "age": 25,
          "gitHub_path_URL": "https://github.com/johndoe",
          "blog_path_URL": "https://youtube.com/johndoe",
          "introduce": "iOS Developer",
          "contents": [
            {
              "contents_id": "aaaaaaa",
              "title": "Project A",
              "content": "Description of Project A"
            },
            {
              "contents_id": "bbbbbbb",
              "title": "Project B",
              "content": "Description of Project B"
            }
          ],
          "password": "hashed_password",
          "image_path_URL": "https://example.com/profile.jpg"
        },
        {
          "user_id": "UUID",
          "name": "John Doe",
          "MBTI": "INTJ",
          "nickname": "johnny",
          "age": 25,
          "gitHub_path_URL": "https://github.com/johndoe",
          "blog_path_URL": "https://youtube.com/johndoe",
          "introduce": "iOS Developer",
          "contents": [
            {
              "contents_id": "aaaaaaa",
              "title": "Project A",
              "content": "Description of Project A"
            },
            {
              "contents_id": "bbbbbbb",
              "title": "Project B",
              "content": "Description of Project B"
            }
          ],
          "password": "hashed_password",
          "image_path_URL": "https://example.com/profile.jpg"
        }
        ]
        """
        return try! JSONDecoder().decode([User].self, from: user.data(using: .utf8)!)
    }
}
