import XCTest
@testable import TCA

final class MyAccountReducerTests: XCTestCase {
    func testRemoveBubblesUp() {
        var state = MyAccountState()
        let effect = myAccountReducer.reduce(&state, .remove("ID123"), ())
        let expectation = XCTestExpectation(description: "Effect emits all actions")
        var output: [MyAccountAction] = []
        let cancellable = effect.publisher
            .sink(receiveValue: { value in
                output.append(value)
                expectation.fulfill()
            })
        _ = XCTWaiter.wait(for: [expectation], timeout: 0.1)
        cancellable.cancel()
        XCTAssertEqual(output, [.remove("ID123")])
    }
    
    func testLogoutNoEffect() {
        var state = MyAccountState()
        let effect = myAccountReducer.reduce(&state, .logout, ())
        let expectation = XCTestExpectation(description: "Effect emits all actions")
        expectation.isInverted = true
        let cancellable = effect.publisher
            .sink(receiveValue: { _ in
                expectation.fulfill()
            })
        _ = XCTWaiter.wait(for: [expectation], timeout: 0.1)
        cancellable.cancel()
    }
} 