//
//  ArrayX.swift
//  ABGAugeViewV2
//
//  Created by Ajay Bhanushali on 19/07/18.
//  Copyright © 2018 Aimpact. All rights reserved.
//

import Foundation

extension Array {
    mutating func rearrange(from: Int, to: Int) {
        precondition(from != to && indices.contains(from) && indices.contains(to), "invalid indexes")
        insert(remove(at: from), at: to)
    }
}
