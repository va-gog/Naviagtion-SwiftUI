import XCTest
@testable import TCA

final class MainScreenReducerTests: XCTestCase {
    func testAddAndRemoveItem() {
        var state = MainScreenState()
        _ = mainScreenReducer.reduce(&state, .add("ID123"), ())
        XCTAssertEqual(state.items, ["ID123"])
        _ = mainScreenReducer.reduce(&state, .remove("ID123"), ())
        XCTAssertEqual(state.items, [])
    }
} 