//
//  MainScreenReducerTests.swift
//  TCA
//
//  Created by Gohar Vardanyan on 02.06.25.
//

import XCTest
import Combine
@testable import TCA

final class MainScreenReducerTests: XCTestCase {
    func testAddItem() {
        var state = MainScreenState()
        let item = ForecastItemModel(id: 1, name: "Test")
        _ = mainScreenReducer.reduce(&state, .add(item), ())
        XCTAssertTrue(state.items.contains(item))
    }

    func testRemoveItem() {
        let item = ForecastItemModel(id: 1, name: "Test")
        var state = MainScreenState(items: [item])
        _ = mainScreenReducer.reduce(&state, .remove(1), ())
        XCTAssertFalse(state.items.contains(item))
    }
}
