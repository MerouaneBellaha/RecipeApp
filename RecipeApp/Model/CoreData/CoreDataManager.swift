//
//  CoreDataManager.swift
//  travelApp
//
//  Created by Merouane Bellaha on 15/07/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import CoreData

//enum Predicate {
//    case currency(String)
//    case text(String)
//
//    var format: NSPredicate {
//        switch self {
//        case .currency(let currency):
//            return NSPredicate(format: K.currencyFormat, currency)
//        case .text(let text):
//            return NSPredicate(format: K.taskFormat, text)
//        }
//    }
//}


final class CoreDataManager {

    // MARK: - Properties

    private var context: NSManagedObjectContext
    private var coreDataStack: CoreDataStack

    // MARK: - Init

    init(with coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.context = coreDataStack.context
    }

    // MARK: - Methods

    func testprint() {
        print("j'existe")
    }
    //    func loadItems<T: NSManagedObject>(entity: T.Type, predicate: Predicate? = nil, sortBy key: String? = nil) -> [T] {
    //        let request = T.fetchRequest()
    //
    //        if let predicate = predicate {
    //            request.predicate = predicate.format
    //        }
    //        if let key = key {
    //            request.sortDescriptors = [NSSortDescriptor(key: key, ascending: true)]
    //        }
    //
    //        guard let items = try? (context.fetch(request).compactMap { $0 as? T }) else { return [] }
    //        return items
    //    }
    //
    //    func createItem(callBack: @escaping ((RecipeModel) -> ())) {
    //        let newRecipe = RecipeModel(context: context)
    //        callBack(newRecipe)
    //        coreDataStack.saveContext()
    //    }

    func loadFavorites(with predicate: String? = nil) -> [RecipeModel] {
        let request: NSFetchRequest<RecipeModel> = RecipeModel.fetchRequest()

        if let predicate = predicate {
            request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", predicate)
        }

        guard let favoriteRecipes = try? context.fetch(request) else { return [] }
        return favoriteRecipes

    }

    func createFavorite(from recipeViewModel: RecipeViewModel) {
        let newRecipe = RecipeModel(context: context)
        newRecipe.name = recipeViewModel.name
        newRecipe.pictureData = recipeViewModel.image
        newRecipe.time = recipeViewModel.time
        newRecipe.yield = recipeViewModel.yield
        newRecipe.ingredientsOverview = recipeViewModel.ingredientsOverview
        coreDataStack.saveContext()
    }

    func deleteFavorite(named name: String) {
        let favoriteToDelete = loadFavorites(with: name)
        favoriteToDelete.forEach { context.delete($0) }
        coreDataStack.saveContext()
    }

    func containsFavorite(named name: String) -> Bool {
        let favorite = loadFavorites(with: name)
        return !favorite.isEmpty
    }

    func deleteAllFavorites() {
        loadFavorites().forEach { context.delete($0) }
        coreDataStack.saveContext()
    }
}


//
//    func deleteItems<T: NSManagedObject>(entity: T.Type) {

//
//    func deleteItem<T: NSManagedObject>(item: T) {
//        context.delete(item)
//        coreDataStack.saveContext()
//    }

