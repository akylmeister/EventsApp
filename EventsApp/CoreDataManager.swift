//
//  CoreDataManager.swift
//  EventsApp
//
//  Created by admin on 04.06.2022.
//

import CoreData
import UIKit

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "EventsApp")
        persistentContainer.loadPersistentStores { _, error in
            print(error?.localizedDescription ?? "")
        }
        return persistentContainer
    }()
    
    var moc: NSManagedObjectContext{
        persistentContainer.viewContext
    }
    
    func getEvent(_ id: NSManagedObjectID) -> Event? {
        do {
            return try moc.existingObject(with: id) as? Event
        }
        catch {
            print(error)
        }
        return nil
    }
    
    func saveEvent(name: String, date: Date, image: UIImage){
        let event = Event(context: moc)
        event.setValue(name, forKey: "name")
        
        let resizedImage = image.sameAspectRatio(newHeight: 250)
        
        event.setValue(date, forKey: "date")
        let imageData = resizedImage.jpegData(compressionQuality: 0.5)
        event.setValue(imageData, forKey: "image")
        
        do {
            try moc.save()
        }
        catch{
            print(error)
        }
    }
    
    func updateEvent(event: Event, name: String, date: Date, image: UIImage){
        event.setValue(name, forKey: "name")
        
        let resizedImage = image.sameAspectRatio(newHeight: 250)
        
        event.setValue(date, forKey: "date")
        let imageData = resizedImage.jpegData(compressionQuality: 0.5)
        event.setValue(imageData, forKey: "image")
        
        do {
            try moc.save()
        }
        catch{
            print(error)
        }
    }
    
    func fetchEvent() -> [Event] {
        do {
            let fetchRequest = NSFetchRequest<Event>(entityName: "Event")
            let events = try moc.fetch(fetchRequest)
            return events
        }
        catch {
            print(error)
            return []
        }
    }
}
