//
//  AccountState.swift
//  money-arch
//
//  Created by Maxime CHAPELET on 28/01/2019.
//  Copyright © 2019 Maxime CHAPELET. All rights reserved.
//

import Foundation

protocol AccountState {
    var name:String {get}
    var transactions:TransactionsListState {get}
}

protocol MutableAccountState {
    var name:String {get set}
    var transactions:TransactionsListState {get set}
}
