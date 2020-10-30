//
//  CoreDataManager.swift
//  travelApp
//
//  Created by Merouane Bellaha on 15/07/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import CoreData

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

    func loadFavorites(with predicate: String? = nil) -> [RecipeEntity] {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()

        if let predicate = predicate {
            request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", predicate)
        }

        guard let favoriteRecipes = try? context.fetch(request) else { return [] }
        return favoriteRecipes
    }

    func addFavorite(from recipeViewModel: RecipeViewModel) {
        let newRecipe = RecipeEntity(context: context)
        newRecipe.name = recipeViewModel.name
        newRecipe.pictureData = recipeViewModel.pictureData
        newRecipe.cookingTime = recipeViewModel.cookingTime
        newRecipe.yield = recipeViewModel.yield
        newRecipe.ingredientsOverview = recipeViewModel.ingredientsOverview
        newRecipe.ingredientsList = recipeViewModel.ingredients
        newRecipe.url = recipeViewModel.url
        coreDataStack.saveContext()
    }

    func deleteFavorite(named name: String) {
        let favoriteToDelete = loadFavorites(with: name)
        favoriteToDelete.forEach { context.delete($0) }
        coreDataStack.saveContext()
    }

    func isContainingFavorite(named name: String) -> Bool {
        let favorite = loadFavorites(with: name)
        return !favorite.isEmpty
    }
}
