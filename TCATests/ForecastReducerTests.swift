//
//  ForecastReducerTests.swift
//  TCA
//
//  Created by Gohar Vardanyan on 02.06.25.
//

import XCTest
import Combine
@testable import TCA

final class ForecastReducerTests: XCTestCase {
    func testAddEmitsAddItem() {
        var state = ForecastState()
        let effect = forecastReducer.reduce(&state, .add, ())
        let received = effect.collectAll()
        XCTAssertEqual(received, [.addItem(ForecastItemModel(id: 1, name: "Added Item"))])
    }
}
