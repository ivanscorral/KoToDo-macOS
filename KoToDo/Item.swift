//
//  Item.swift
//  KoToDo
//
//  Created by Ivan Sanchez on 4/11/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
