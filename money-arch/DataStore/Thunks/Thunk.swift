//
//  Thunk.swift
//  money-arch
//
//  Created by Maxime CHAPELET on 22/01/2019.
//  Copyright © 2019 Maxime CHAPELET. All rights reserved.
//

import Foundation


class Thunk<State> : Action {
    typealias Callbacks = (_ dispatch:(Action)->Void, _ state:()->State)->Void
    let callbacks:Callbacks
    init(_ callbacks:@escaping Callbacks) {
        self.callbacks = callbacks
    }
}
