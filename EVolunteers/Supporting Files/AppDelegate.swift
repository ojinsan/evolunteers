//
//  AppDelegate.swift
//  EVolunteers
//
//  Created by Dedy Yuristiawan on 12/05/20.
//  Copyright © 2020 Dedy Yuristiawan. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()


}

extension AppDelegate {
    
//    static func saveData(_ foods: [FoodInTake]) {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        let managedContext = appDelegate.persistentContainer.viewContext
//        for food in foods {
//            let nFood = NSEntityDescription.insertNewObject(forEntityName: "Programs", into: managedContext)
//            nFood.setValue(food.id, forKey: "id")
//        }
//        do {
//            try managedContext.save()
//            print("Success")
//        } catch {
//            print("Error saving: \(error)")
//        }
//    }
    
//    static func retrieveSaved() -> [FoodInTake]? {
//        var retrievedFoods: [FoodInTake] = []
//
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return retrievedFoods }
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FoodInTakes")
//        request.returnsObjectsAsFaults = false
//        do {
//            let results = try managedContext.fetch(request)
//            if !results.isEmpty {
//                for result in results as! [NSManagedObject] {
//                    guard let id = result.value(forKey: "id") as? String else { return nil }
//                    let food = FoodInTake(id: id, name: name, serving: serving, calories: calories, protein: protein, fat: fat, carb: carb, fiber: fiber)
//                    retrievedFoods.append(food)
//                }
//            }
//        } catch {
//            print("Error retrieving: \(error)")
//        }
//        return retrievedFoods
//    }
    
//    static func updateFood(food: FoodInTake) {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FoodInTakes")
//        request.predicate = NSPredicate(format: "id = %@", "\(food.id)")
//
//        do {
//            let objs = try managedContext.fetch(request)
//
//            let objectUpdate = objs[0] as! NSManagedObject
//            objectUpdate.setValue(food.id, forKey: "id")
//            objectUpdate.setValue(food.name, forKey: "name")
//            objectUpdate.setValue(food.serving, forKey: "serving")
//            objectUpdate.setValue(food.calories, forKey: "calories")
//            objectUpdate.setValue(food.protein, forKey: "protein")
//            objectUpdate.setValue(food.fat, forKey: "fat")
//            objectUpdate.setValue(food.carb, forKey: "carb")
//            objectUpdate.setValue(food.fiber, forKey: "fiber")
//            do{
//                try managedContext.save()
//            }
//            catch
//            {
//                print(error)
//            }
//        }
//        catch {
//            print(error)
//        }
//    }
    
//    static func deleteSavedFood(food: FoodInTake) {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        let managedContext = appDelegate.persistentContainer.viewContext
//
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FoodInTakes")
//        request.predicate = NSPredicate(format: "id = %@", "\(food.id)")
//
//        do{
//            let objs = try managedContext.fetch(request)
//            let objectToDelete = objs[0] as! NSManagedObject
//            managedContext.delete(objectToDelete)
//            do{
//                try managedContext.save()
//            } catch{
//                print(error)
//            }
//        } catch {
//            print(error)
//        }
//    }
}
