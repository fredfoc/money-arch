//
//  DeleteTransactionAction.swift
//  money-arch
//
//  Created by Maxime CHAPELET on 21/01/2019.
//  Copyright © 2019 Maxime CHAPELET. All rights reserved.
//

import Foundation

struct DeleteTransactionAction {
    let uniqueIdentifier:UUID
    init(uniqueIdentifier:UUID) {
        self.uniqueIdentifier = uniqueIdentifier
    }
}

extension DeleteTransactionAction : Action {
    
}
