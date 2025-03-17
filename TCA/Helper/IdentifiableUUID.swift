//
//  IdentifiableUUID.swift
//  TCA
//
//  Created by Gohar Vardanyan on 11.03.25.
//

import Foundation

struct IdentifiableUUID: Identifiable, Hashable {
    let id: UUID = UUID()
}
