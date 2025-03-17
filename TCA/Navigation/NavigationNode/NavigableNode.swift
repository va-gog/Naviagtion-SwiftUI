//
//  NavigableNode.swift
//  TCA
//
//  Created by Gohar Vardanyan on 11.03.25.
//

import SwiftUI

protocol NavigableNode: AnyObject {
    var uuid: IdentifiableUUID { get }
    var parent: (any NavigableState)? { get set }
    var reducer: (any Reducer)? { get set}
    
    func navigateAction(action: Action)
}
