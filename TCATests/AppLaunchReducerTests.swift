//
//  AppLaunchReducerTests.swift
//  TCA
//
//  Created by Gohar Vardanyan on 02.06.25.
//

import XCTest
import Combine
@testable import TCA

final class AppLaunchReducerTests: XCTestCase {
    func testOnAppearPresentsLocPermition() {
        var state = AppLaunchState()
        let effect = appLaunchReducer.reduce(&state, .onAppear, ())
        let received = effect.collectAll()
        guard case .navigation(.present(.locPermition(_))) = received.first else {
            XCTFail("Expected navigation present Location Permition View")
            return
        }
    }

    func testLocationPermitionPresentsAuthentication() {
        var state = AppLaunchState()
        let effect = appLaunchReducer.reduce(&state, .locPermitionAction(.locationAccessPermited), ())
        let received = effect.collectAll()
        guard case .navigation(.present(.authentication(_))) = received.first else {
            XCTFail("Expected navigation present Authentication View")
            return
        }
    }

    func testAuthenticationLoggedInPresentsMain() {
        var state = AppLaunchState()
        let effect = appLaunchReducer.reduce(&state, .authenticationAction(.loggedIn), ())
        let received = effect.collectAll()
        XCTAssertTrue(received.contains(.navigation(.dismiss)))
        guard case .navigation(.push(.main(_))) = received.last else {
            XCTFail("Expected navigation present Main View")
            return
        }
    }

    func testPushForecastView() {
        var state = AppLaunchState()
        let effect = appLaunchReducer.reduce(&state, .mainScreenAction(.pushForecastView), ())
        let received = effect.collectAll()
        guard case .navigation(.push(.forecast(_))) = received.first else {
            XCTFail("Expected navigation present Forevast View")
            return
        }
    }

    func testPresentSettingsView() {
        var state = AppLaunchState()
        let effect = appLaunchReducer.reduce(&state, .mainScreenAction(.presentSettingsView), ())
        let received = effect.collectAll()
        guard case .navigation(.present(.settings(_))) = received.first else {
            XCTFail("Expected navigation present Settings View")
            return
        }
    }

    func testForecastLogoutResetsToAuthentication() {
        var state = AppLaunchState()
        let effect = appLaunchReducer.reduce(&state, .forecastAction(.logout), ())
        let received = effect.collectAll()
        XCTAssertTrue(received.contains(.navigation(.popToRoot)))
        guard case .navigation(.present(.authentication(_))) = received.last else {
            XCTFail("Expected navigation present Authentication View")
            return
        }
    }

    func testForecastAddItemBubblesToMainScreen() {
        var state = AppLaunchState()
        let item = ForecastItemModel(id: 1, name: "Added Item")
        let effect = appLaunchReducer.reduce(&state, .forecastAction(.addItem(item)), ())
        let received = effect.collectAll()
        XCTAssertEqual(received, [
            .mainScreenAction(.add(item)),
            .navigation(.pop)
        ])
    }

    func testSettingsCloseDismisses() {
        var state = AppLaunchState()
        let effect = appLaunchReducer.reduce(&state, .settingsAction(.close), ())
        let received = effect.collectAll()
        XCTAssertEqual(received, [.navigation(.dismiss)])
    }
}
