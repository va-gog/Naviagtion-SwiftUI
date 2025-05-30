import XCTest
@testable import TCA

final class SettingsReducerTests: XCTestCase {
    func testMyAccountCreatesState() {
        var state = SettingsState()
        let effect = settingsReducer.reduce(&state, .myAccount, ())
        XCTAssertNotNil(state.myAccountState)
        let expectation = XCTestExpectation(description: "Effect emits all actions")
        expectation.isInverted = true
        let cancellable = effect.publisher
            .sink(receiveValue: { _ in
                expectation.fulfill()
            })
        _ = XCTWaiter.wait(for: [expectation], timeout: 0.1)
        cancellable.cancel()
    }
    
    func testMyAccountActionRemoveBubblesUp() {
        var state = SettingsState(myAccountState: MyAccountState())
        let effect = settingsReducer.reduce(&state, .myAccountAction(.remove("ID123")), ())
        let expectation = XCTestExpectation(description: "Effect emits all actions")
        var output: [SettingsViewAction] = []
        let cancellable = effect.publisher
            .sink(receiveValue: { value in
                output.append(value)
                expectation.fulfill()
            })
        _ = XCTWaiter.wait(for: [expectation], timeout: 0.1)
        cancellable.cancel()
        XCTAssertEqual(output, [.myAccountDidRemove("ID123")])
    }
} 