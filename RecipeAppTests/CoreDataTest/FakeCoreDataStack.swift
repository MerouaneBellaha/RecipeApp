//
//  FakeCoreDataStack.swift
//  RecipeAppTests
//
//  Created by Merouane Bellaha on 17/10/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import Foundation

import RecipeApp
import CoreData

final class FakeCoreDataStack: CoreDataStack {

    // MARK: - Init

    convenience init() {
        self.init(containerName: "RecipeModel")
    }

    override init(containerName : String) {
        super.init(containerName: containerName)
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        let container = NSPersistentContainer(name: containerName)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        self.persistentContainer = container
    }
}
