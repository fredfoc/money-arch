//
//  Scenes.swift
//  money-arch
//
//  Created by Maxime CHAPELET on 17/01/2019.
//  Copyright © 2019 Maxime CHAPELET. All rights reserved.
//

import AppKit

enum Scenes {
    enum Factory {
        static func createMainWindow() -> NSWindowController {
            let controller:MainWindowController = MainWindowController(windowNibName: NSNib.Name(rawValue: "MainWindowController"))
            controller.window?.contentViewController = createMainStage()
            return controller
            
        }
        static func createMainStage() -> NSViewController {
            let mainStage = MainStageViewController(outline: createOutline(), transactions: createTransactions())
            return mainStage
        }
        static func createOutline() -> NSViewController {
            let outline = OutlineViewController(nibName: nil, bundle: nil)
            return outline
        }
        static func createTransactions() -> NSViewController {
            let transactions = TransactionsViewController(nibName: nil, bundle: nil)
            return transactions
        }
    }
}
