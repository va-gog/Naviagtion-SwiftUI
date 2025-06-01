//
//  Effect.swift
//  TCA
//
//  Created by Gohar Vardanyan on 16.05.25.
//

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
    
    func map<B>(_ transform: @escaping (Action) -> B) -> Effect<B> {
        Effect<B>(self.publisher.map(transform))
    }
    
    func merge(with other: Effect) -> Effect {
        Effect(
            Publishers.Merge(self.publisher, other.publisher)
                .eraseToAnyPublisher()
        )
    }
    
    static func concatenate(_ effects: Effect...) -> Effect {
        return .init(
            effects
                .map { $0.publisher }
                .reduce(Empty<Action, Never>().eraseToAnyPublisher()) { acc, next in
                    acc.append(next).eraseToAnyPublisher()
                }
        )
    }
}
