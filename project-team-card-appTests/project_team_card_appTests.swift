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
    //유저 커스텀 데이터 테스트 코드
    @Test func getUserData() async throws{
        let user = CustomData.shared.user
        print("user : \(user)")
        #expect(user.userID == "UUID")
    }
    //유저 리스트 커스텀 데이터 테스트 코드
    @Test func getUserListData() async throws{
        let list = CustomData.shared.userList
        print("user : \(list[1])")
        #expect(list[1].userID == "UUID1")
    }
}
