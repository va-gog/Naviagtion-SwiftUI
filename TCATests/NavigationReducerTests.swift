//
//  NavigationReducerTests.swift
//  TCA
//
//  Created by Gohar Vardanyan on 02.06.25.
//

import XCTest
import Combine
@testable import TCA

final class NavigationReducerTests: XCTestCase {
    func testPushAddsToNavigationPath() {
        var state = AppNavigationState()
        let screen = AppScreenState.main(MainScreenState())
        _ = navigationReducer().reduce(&state, .push(screen), ())
        XCTAssertEqual(state.navigationPath.last, screen)
    }

    func testPopRemovesFromNavigationPath() {
        let screen = AppScreenState.main(MainScreenState())
        var state = AppNavigationState(navigationPath: [screen])
        _ = navigationReducer().reduce(&state, .pop, ())
        XCTAssertTrue(state.navigationPath.isEmpty)
    }

    func testPresentSetsScreenCoverState() {
        var state = AppNavigationState()
        let screen = AppScreenState.settings(SettingsState())
        _ = navigationReducer().reduce(&state, .present(screen), ())
        XCTAssertEqual(state.screenCoverState, screen)
    }
}
