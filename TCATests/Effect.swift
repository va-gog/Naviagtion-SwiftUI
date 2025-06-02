//
//  Effect.swift
//  TCA
//
//  Created by Gohar Vardanyan on 02.06.25.
//

import XCTest
import Combine
@testable import TCA

extension Effect {
    func collectAll(timeout: TimeInterval = 0.1) -> [Action] {
        var values: [Action] = []
        let exp = XCTestExpectation(description: "collectAll")
        let cancellable = self.publisher.sink { value in
            values.append(value)
            exp.fulfill()
        }
        _ = XCTWaiter.wait(for: [exp], timeout: timeout)
        cancellable.cancel()
        return values
    }
}
