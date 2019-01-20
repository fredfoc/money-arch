//
//  MainWindowController.swift
//  money-arch
//
//  Created by Maxime CHAPELET on 17/01/2019.
//  Copyright © 2019 Maxime CHAPELET. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    var transactions: NSViewController?
    var outline: NSViewController?
    
    override init(window: NSWindow?) {
        super.init(window: window)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

        if let transactions = self.transactions {
            window?.contentViewController
        }
        
        if let outline = self.outline {
            
        }
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
}
