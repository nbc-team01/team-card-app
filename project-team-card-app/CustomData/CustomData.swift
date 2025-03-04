//
//  CustomData.swift
//  project-team-card-app
//
//  Created by 유영웅 on 3/4/25.
//

import Foundation

class CustomData{
    static let shared = CustomData()
    private init(){}
    
    var user:User{
        let user = """
        {
          "userId": "UUID",
          "name": "John Doe",
          "MBTI": "INTJ",
          "nickname": "johnny",
          "age": 25,
          "gitHub_path_URL": "https://github.com/johndoe",
          "blog_path_URL": "https://youtube.com/johndoe",
          "introduce": "iOS Developer",
          "contents": [
            { "title": "Project A", "content": "Description of Project A" },
            { "title": "Project B", "content": "Description of Project B" }
          ],
          "password": "hashed_password",
          "image_path_URL": "https://example.com/profile.jpg"
        }
        """
        return try! JSONDecoder().decode(User.self, from: user.data(using: .utf8)!)
    }
    
    var userList:[User]{
        let user = """
        [
            {
              "userId": "UUID",
              "name": "John Doe",
              "MBTI": "INTJ",
              "nickname": "johnny",
              "age": 25,
              "gitHub_path_URL": "https://github.com/johndoe",
              "blog_path_URL": "https://youtube.com/johndoe",
              "introduce": "iOS Developer",
              "contents": [
                { "title": "Project A", "content": "Description of Project A" },
                { "title": "Project B", "content": "Description of Project B" }
              ],
              "password": "hashed_password",
              "image_path_URL": "https://example.com/profile.jpg"
            },
            {
              "userId": "UUID1",
              "name": "John Doe",
              "MBTI": "INTJ",
              "nickname": "johnny",
              "age": 25,
              "gitHub_path_URL": "https://github.com/johndoe",
              "blog_path_URL": "https://youtube.com/johndoe",
              "introduce": "iOS Developer",
              "contents": [
                { "title": "Project A", "content": "Description of Project A" },
                { "title": "Project B", "content": "Description of Project B" }
              ],
              "password": "hashed_password",
              "image_path_URL": "https://example.com/profile.jpg"
            },
            {
              "userId": "UUID2",
              "name": "John Doe",
              "MBTI": "INTJ",
              "nickname": "johnny",
              "age": 25,
              "gitHub_path_URL": "https://github.com/johndoe",
              "blog_path_URL": "https://youtube.com/johndoe",
              "introduce": "iOS Developer",
              "contents": [
                { "title": "Project A", "content": "Description of Project A" },
                { "title": "Project B", "content": "Description of Project B" }
              ],
              "password": "hashed_password",
              "image_path_URL": "https://example.com/profile.jpg"
            }
        ]
        """
        return try! JSONDecoder().decode([User].self, from: user.data(using: .utf8)!)
    }
}
