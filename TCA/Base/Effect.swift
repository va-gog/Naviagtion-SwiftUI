import Combine

public struct Effect<Action> {
    public let publisher: AnyPublisher<Action, Never>
    
    public static var none: Effect {
        Effect(Empty().eraseToAnyPublisher())
    }
    
    public static func just(_ value: Action) -> Effect {
        Effect(Just(value).eraseToAnyPublisher())
    }
    
    public init<P: Publisher>(_ publisher: P) where P.Output == Action, P.Failure == Never {
        self.publisher = publisher.eraseToAnyPublisher()
    }
} 
