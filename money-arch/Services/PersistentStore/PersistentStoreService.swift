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
        enum Error : Swift.Error {
            case UnexpectedNilProperty
        }
        internal var guid: UUID
        internal var name: String
        fileprivate init (name:String) {
            self.name = name
            self.guid = UUID()
        }
        fileprivate init (from other:Account) {
            self.guid = other.guid
            self.name = other.name
        }
        fileprivate init (from managedObject:AccountManagedObject) throws {
            guard let name = managedObject.name else {
                 throw Error.UnexpectedNilProperty
            }
            guard let guid = managedObject.guid else {
                throw Error.UnexpectedNilProperty
            }
            self.guid = guid
            self.name = name
        }
    }
}

extension Services.PersistentStore.Account : PersistentStoreAccount {
    internal func mutable() -> MutablePersistentStoreAccount {
        return Services.PersistentStore.Account(from: self)
    }
}

extension Services.PersistentStore.Account : MutablePersistentStoreAccount {
    
}

extension Services.PersistentStore.Service : PersistentStore {
    func insertAccount(name: String, _ completion: @escaping (PersistentStoreAccount) -> Void) {
        let account = Services.PersistentStore.Account(name: name)
        let context = persistentContainer.viewContext
        context.perform {
            let managedAccount:AccountManagedObject = AccountManagedObject(context: context)
            managedAccount.guid = account.guid
            managedAccount.name = account.name
            do {
                try context.save()
                completion(account)
            } catch {
                
            }
        }
    }
    
    func listAccounts(_ completion: @escaping ([PersistentStoreAccount]) -> Void) {
        let context = persistentContainer.viewContext
        context.perform {
            let request:NSFetchRequest<AccountManagedObject> = AccountManagedObject.fetchRequest()
            do {
                let result:[AccountManagedObject] = try request.execute()
                var accounts = [PersistentStoreAccount]()
                
                for managedAccount in result {
                    let account = try Services.PersistentStore.Account(from: managedAccount)
                    accounts.append(account)
                }
                completion(accounts)
            } catch {
                
            }
        }
    }
    
    func updateAccount(_ account: PersistentStoreAccount,
                       _ completion: @escaping (PersistentStoreAccount) -> Void) {
        let context = persistentContainer.viewContext
        context.perform {
            let request:NSFetchRequest<AccountManagedObject> = AccountManagedObject.fetchRequest()
            request.predicate = NSPredicate(format: "guid = %@", account.guid as CVarArg)
            do {
                let result:[AccountManagedObject] = try request.execute()
                guard let first = result.first else {return}
                first.name = account.name
                let account = try Services.PersistentStore.Account(from: first)
                try context.save()
                completion(account)
            } catch {
                
            }
        }
    }
    
}
