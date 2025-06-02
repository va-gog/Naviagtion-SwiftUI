//
//  State.swift
//  TCA
//
//  Created by Gohar Vardanyan on 02.06.25.
//

import Foundation

protocol State: Hashable, Identifiable {
    var id: UUID { get }
}
