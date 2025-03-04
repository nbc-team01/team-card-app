//
//  project_team_card_appTests.swift
//  project-team-card-appTests
//
//  Created by 유영웅 on 3/3/25.
//

import Testing
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
    @Test func setUserData() async throws{
        try await UserAPIService.saveUser(user: CustomData.shared.user)
    }
    @Test func fetchUserDate() async throws{
        let user = try await UserAPIService.fetchUser(userId: "UUID")
        print(user)
        #expect(user.mbti == "INTJ")
    }
}
