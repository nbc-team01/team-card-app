//
//  project_team_card_appTests.swift
//  project-team-card-appTests
//
//  Created by 유영웅 on 3/3/25.
//

import Testing
import UIKit
@testable import project_team_card_app

struct project_team_card_appTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }
    //user custom data test code..
    @Test func getUserData() async throws{
        let user = CustomData.shared.user
        print("user : \(user)")
        #expect(user.userID == "UUID")
    }
    //user list custom data test code..
    @Test func getUserListData() async throws{
        let list = CustomData.shared.userList
        print("user : \(list[1])")
        #expect(list[1].userID == "UUID1")
    }
    //stored in the user data DB test code..
    @Test func setUserData() async throws{
        try await UserAPIService.setUser(user: CustomData.shared.user)
    }
    //fetching in the user data DB test code..
    @Test func fetchUserData() async throws{
        let user = try await UserAPIService.fetchUser(userId: "UUID")
        #expect(user.mbti == "INTJ")
    }
    //updating in the user data DB test code..
    @Test func updateUserData() async throws {
        let user = User(userID: "UUID",name:"QQQQ")
        try await UserAPIService.updateUser(user: user)
    }
    //deleting in the user data DB test code..
    @Test func deleteUserData() async throws {
        try await UserAPIService.deleteUser(userId: "UUID")
    }
    //fetching in the users data DB test code..
    @Test func fetchUsersData() async throws {
        let users = try await UserAPIService.fetchUsers()
        #expect(users.first?.mbti == "INTJ")
    }
    //isValid in ther users password test code..
    @Test func isValidPassword() async throws {
        let isValid = try await UserAPIService.isValidPassword(userId: "UUID", password: "hashed_password")
        #expect(isValid)
    }
    //save the image and get the url test code..
    @Test func setIamge() async throws {
        let image = UIImage(named: "github-mark")!
        let url = try await StorageAPIService.setImage(image, userId: "UUID")
        print(url)
    }
}
