//
//  PersistenceManager.swift
//  AnnualDiary
//
//  Created by dev team on 2023/03/09.
//

import CoreData
import SwiftUI
import Combine

public class PersistenceManager {
    public static let shared = PersistenceManager()
    
    lazy var container: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "AnnualDiary")
        
        guard let storeDescription = container.persistentStoreDescriptions.first else {
            fatalError("###\(#function): Failed to retrieve a persistent store description.")
        }
        
        storeDescription.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        storeDescription.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
//        storeDescription.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "iCloud.com.mooq.diary")
        storeDescription.configuration = "Default"
        storeDescription.timeout = 3
        container.persistentStoreDescriptions = [storeDescription]
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        return container
    }()
    
    // MARK: - Core Data support
    private func save () {
        if container.viewContext.hasChanges {
            do {
                try self.container.viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveContext() {
        let context = self.container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetch<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T] {
        do {
            let fetchResult = try self.container.viewContext.fetch(request)
            return fetchResult
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    @discardableResult func delete(object: NSManagedObject) -> Bool {
        self.container.viewContext.delete(object)
        do{
            try self.container.viewContext.save()
            return true
        } catch {
            return false
        }
    }
    
    @discardableResult func deleteAll<T: NSManagedObject>(request: NSFetchRequest<T>) -> Bool {
        let request: NSFetchRequest<NSFetchRequestResult> = T.fetchRequest()
        let delete = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try self.container.viewContext.execute(delete)
            return true
        } catch {
            return false
        }
    }
    
    private func count<T: NSManagedObject>(request: NSFetchRequest<T>) -> Int? {
        do {
            let count = try self.container.viewContext.count(for: request)
            return count
        } catch {
            return nil
        }
    }
    
    @discardableResult func removeAllEntityData(entityName: String) -> Bool {
        let ReqVar = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: ReqVar)
        do {
            try self.container.viewContext.execute(DelAllReqVar)
            return true
        }
        catch { return false }
    }
    
//    //MARK: -Diary
//    func setDiary(item: DiaryViewModel.Item) {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Diary")
//        fetchRequest.predicate = NSPredicate(format: "datestring == %@", item.datestring as CVarArg)
//        do {
//            if let result = try self.container.viewContext.fetch(fetchRequest) as? [Diary] {
//                if result.isEmpty {
//                    let entity = NSEntityDescription.entity(forEntityName: "Diary", in: self.container.viewContext)
//                    if let entity = entity {
//                        let info = NSManagedObject(entity: entity, insertInto: self.container.viewContext)
//                        info.setValue(item.datestring, forKey: "datestring")
//                        info.setValue(item.mood, forKey: "mood")
//                        info.setValue(item.saveddate ?? Date(), forKey: "saveddate")
//                        info.setValue(item.text, forKey: "text")
//                        info.setValue(item.weather, forKey: "weather")
//                    }
//                } else {
//                    let info = result.first
//                    info?.mood = item.mood
//                    info?.saveddate = item.saveddate
//                    info?.text = item.text
//                    info?.weather = item.weather
//                }
//                save()
//            }
//        } catch {
//            print(error)
//        }
//    }
//
//    func deleteDiary(dateString: String) {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Diary")
//        fetchRequest.predicate = NSPredicate(format: "datestring == %@", dateString as CVarArg)
//        do {
//            if let result = try self.container.viewContext.fetch(fetchRequest) as? [Diary] {
//                for object in result {
//                    self.container.viewContext.delete(object)
//                }
//                save()
//            }
//        } catch {
//            print(error)
//        }
//    }
//
//    func saveImageData(dateString: String, data: Data, index: Int) {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Userimg")
//        fetchRequest.predicate = NSPredicate(format: "datestring == %@ AND name == %@", dateString as CVarArg, "\(dateString)_\(index)" as CVarArg)
//        do {
//            if let result = try self.container.viewContext.fetch(fetchRequest) as? [Userimg] {
//                if result.isEmpty {
//                    let entity = NSEntityDescription.entity(forEntityName: "Userimg", in: self.container.viewContext)
//                    if let entity = entity {
//                        let info = NSManagedObject(entity: entity, insertInto: self.container.viewContext)
//                        info.setValue(dateString, forKey: "datestring")
//                        info.setValue(data, forKey: "data")
//                        info.setValue("\(dateString)_\(index)", forKey: "name")
//                    }
//                } else {
//                    let info = result.first
//                    info?.data = data
//                }
//                save()
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
}
