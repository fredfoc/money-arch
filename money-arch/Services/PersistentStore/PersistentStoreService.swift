//
//  PersistentStoreService.swift
//  money-arch
//
//  Created by Maxime CHAPELET on 26/01/2019.
//  Copyright © 2019 Maxime CHAPELET. All rights reserved.
//

import Foundation
import CoreData

extension Services {
    enum PersistentStore {
        class Service {
            let persistentContainer: NSPersistentContainer
            init (persistentContainer: NSPersistentContainer) {
                self.persistentContainer = persistentContainer
            }
        }
    }
}

extension Services.PersistentStore {
    class Account {
        internal var guid: UUID
        internal var name: String
        init(name:String) {
            self.name = name
            self.guid = UUID()
        }
    }
}

extension Services.PersistentStore.Account : PersistentStoreAccount {
    
}

extension Services.PersistentStore.Service : PersistentStore {
    func insertAccount(name: String, _ completion: @escaping (PersistentStoreAccount) -> Void) {
        let account = Services.PersistentStore.Account(name: name)
        let context = persistentContainer.viewContext
        context.perform {
            guard let entity = NSEntityDescription.entity(forEntityName: "AccountManagedObject", in: context) else {return}
            let managedAccount:AccountManagedObject = AccountManagedObject(entity: entity, insertInto: context)
            managedAccount.guid = account.guid
            managedAccount.name = account.name
            do {
                try context.save()
                completion(account)
            } catch {
                
            }
        }
    }
    
    
}
