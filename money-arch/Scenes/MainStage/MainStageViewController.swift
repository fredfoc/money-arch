//
//  MainStageViewController.swift
//  money-arch
//
//  Created by Maxime CHAPELET on 18/01/2019.
//  Copyright © 2019 Maxime CHAPELET. All rights reserved.
//

import Cocoa

class MainStageViewController: NSViewController {
    @IBOutlet weak var outlineContainerView: NSView!
    @IBOutlet weak var transactionsContainerView: NSView!
    
    let outline: NSViewController
    let transactions: NSViewController
    
    required init(outline: NSViewController,
         transactions: NSViewController) {
        self.outline = outline
        self.transactions = transactions
        super.init(nibName: nil, bundle: nil)
    }
    
    private override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        fatalError()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addOutline() {
        addChildViewController(outline)
        outlineContainerView.addSubview(outline.view)
        outline.view.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[outlineView]-0-|", options: [], metrics: nil, views: ["outlineView" : outline.view])
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[outlineView]-0-|", options: [], metrics: nil, views: ["outlineView" : outline.view])
        NSLayoutConstraint.activate(horizontalConstraints)
        NSLayoutConstraint.activate(verticalConstraints)
    }
    
    fileprivate func addTransactions() {
        addChildViewController(transactions)
        transactionsContainerView.addSubview(transactions.view)
        transactions.view.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[transactionView]-0-|", options: [], metrics: nil, views: ["transactionView" : transactions.view])
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[transactionView]-0-|", options: [], metrics: nil, views: ["transactionView" : transactions.view])
        NSLayoutConstraint.activate(horizontalConstraints)
        NSLayoutConstraint.activate(verticalConstraints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addOutline()
        addTransactions()
        // Do view setup here.
    }
    
}

extension MainStageViewController : MainStageViewing {
    
}
