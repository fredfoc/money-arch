//
//  OutlineProtocols.swift
//  money-arch
//
//  Created by Maxime CHAPELET on 28/01/2019.
//  Copyright © 2019 Maxime CHAPELET. All rights reserved.
//

import Foundation

protocol OutlinePresenting {
    func present(_ response:Scenes.Outline.Fetch.Response)
}

protocol OutlineInteracting {
    func fetch(_ request:Scenes.Outline.Fetch.Request)
}
