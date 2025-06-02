import Foundation

struct AppNavigationState: NavigationState, Hashable {
    var navigationPath: [AppScreenState] = []
    var screenCoverState: ScreenState?
}

enum AppScreenState: State, Hashable {
    var id: UUID {
         switch self {
        case .locPermition(let state):
             return state.id
        case .authentication(let state):
             return state.id
        case .main(let state):
             return state.id
        case .settings(let state):
             return state.id
         case .forecast(let state):
              return state.id
        }
    }
    
    case locPermition(LocPermitionState)
    case authentication(AuthenticationState)
    case main(MainScreenState)
    case settings(SettingsState)
    case forecast(ForecastState)
}
