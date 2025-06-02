//
//  MyAccountReducerTests.swift
//  TCA
//
//  Created by Gohar Vardanyan on 02.06.25.
//

import XCTest
import Combine
@testable import TCA

final class MyAccountReducerTests: XCTestCase {
    func testLogoutSetsLoadingAndCompletes() {
        var state = MyAccountState()
        let effect = myAccountReducer.reduce(&state, .didRequestLogout, ())
        var received: [MyAccountAction] = []
        let exp = expectation(description: "Wait for logoutCompleted")
        let cancellable = effect.publisher.sink { action in
            received.append(action)
            if action == .logoutCompleted {
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 3)
        XCTAssertTrue(received.contains(.setLoading(true)))
        XCTAssertTrue(received.contains(.logoutCompleted))
        cancellable.cancel()
    }
}
