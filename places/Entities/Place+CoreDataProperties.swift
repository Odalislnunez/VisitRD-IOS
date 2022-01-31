//
//  Place+CoreDataProperties.swift
//  places
//

import Foundation
import CoreData


extension Place {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Place> {
        return NSFetchRequest<Place>(entityName: "Place")
    }

    @NSManaged public var comments: String?
    @NSManaged public var descrip: String?
    @NSManaged public var id: Int32
    @NSManaged public var images: String?
    @NSManaged public var latitude: Double
    @NSManaged public var location: String?
    @NSManaged public var longitude: Double
    @NSManaged public var name: String?
    @NSManaged public var rating: Double

}

extension Place : Identifiable {

}
