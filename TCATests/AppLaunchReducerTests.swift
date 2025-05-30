import XCTest
@testable import TCA

final class AppLaunchReducerTests: XCTestCase {
    func testOnAppearSetsLocPermitionState() {
        var state = AppLaunchState()
        let effect = appLaunchReducer.reduce(&state, .onAppear, ())
        XCTAssertNotNil(state.locPermitionState)
        let expectation = XCTestExpectation(description: "Effect emits all actions")
        expectation.isInverted = true
        let cancellable = effect.publisher
            .sink(receiveValue: { _ in
                expectation.fulfill()
            })
        _ = XCTWaiter.wait(for: [expectation], timeout: 0.1)
        cancellable.cancel()
    }
    
    func testSettingsActionMyAccountDidRemoveForwardsToMainScreen() {
        var state = AppLaunchState(mainScreenState: MainScreenState())
        let effect = appLaunchReducer.reduce(&state, .settingsAction(.myAccountDidRemove("ID123")), ())
        let expectation = XCTestExpectation(description: "Effect emits all actions")
        var output: [AppLaunchAction] = []
        let cancellable = effect.publisher
            .sink(receiveValue: { value in
                output.append(value)
                expectation.fulfill()
            })
        _ = XCTWaiter.wait(for: [expectation], timeout: 0.1)
        cancellable.cancel()
        XCTAssertEqual(output, [.mainScreenAction(.remove("ID123"))])
    }
} 