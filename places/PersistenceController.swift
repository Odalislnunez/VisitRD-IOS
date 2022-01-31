//
//  PersistenceController.swift
//  places
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Place(context: viewContext)
            newItem.name = "Monumento"
            newItem.location = "Santiago"
            newItem.images = "https://lh5.googleusercontent.com/p/AF1QipM6m4VuHejk_PRf2N41zLcyJG_4FxAx6cl2DZ54=w1080-k-no"
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "PlacesModel")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}

public func clearAllCoreData() {
    let entities = PersistenceController.shared.container.managedObjectModel.entities
    entities.flatMap({ $0.name }).forEach(clearDeepObjectEntity)
}

private func clearDeepObjectEntity(_ entity: String) {
    let context = PersistenceController.shared.container.viewContext

    let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

    do {
        try context.execute(deleteRequest)
        try context.save()
    } catch {
        print ("There was an error")
    }
}
