//
//  CoreDataMethods.swift
//  Todoey
//
//  Created by Andrey on 05.06.2023.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    static var shared = CoreDataManager()

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func createCategory(with name: String) -> Category {
        let newCategory = Category(context: context)
        newCategory.name = name
        saveContext()
        
        return newCategory
    }
    
    func createItem(for category: Category, with name: String) -> Item {
        let newItem = Item(context: context)
        newItem.title = name
        newItem.done = false
        newItem.parentCategory = category
        saveContext()
        
        return newItem
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) -> [Category] {
        var categories: [Category] = []
        
        do {
            categories = try context.fetch(request)
        } catch {
            print("\(error)")
        }
        
        return categories
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil, selectedCategory: Category?) -> [Item] {
        var items: [Item] = []
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                categoryPredicate,
                additionalPredicate
            ])
        } else {
            request.predicate = categoryPredicate
        }
        
        do {
            items = try context.fetch(request)
        } catch {
            print("\(error)")
        }
        
        return items
    }
    
    func deleteCategory(_ category: Category) {
        context.delete(category)
        saveContext()
    }
    
    func deleteItem(_ item: Item) {
        context.delete(item)
        saveContext()
    }
    
    func searchItems(text: String, selectedCategory: Category?) -> [Item] {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let searchPredicate = NSPredicate(format: "title CONTAINS[cd] %@", text)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        return loadItems(with: request, predicate: searchPredicate, selectedCategory: selectedCategory!)
    }
}
