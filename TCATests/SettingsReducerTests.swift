//
//  SettingsReducerTests.swift
//  TCA
//
//  Created by Gohar Vardanyan on 02.06.25.
//

import XCTest
import Combine
@testable import TCA

final class SettingsReducerTests: XCTestCase {
    func testMyAccountPushesView() {
        var state = SettingsState()
        let effect = settingsReducer.reduce(&state, .myAccount, ())
        let received = effect.collectAll()
        guard case let .navigation(.push(.myAccount(accountState))) = received.first else {
            XCTFail("Expected navigation push myAccount")
            return
        }
        XCTAssertTrue(type(of: accountState) == MyAccountState.self)

    }

    func testMyAccountRemoveBubblesUp() {
        var state = SettingsState()
        let effect = settingsReducer.reduce(&state, .myAccountAction(.didRequestRemove(1)), ())
        let received = effect.collectAll()
        XCTAssertEqual(received, [
            .navigation(.pop),
            .myAccountDidRequestRemove(1)
        ])
    }
}
